import-module au

$releases    = 'https://github.com/hluk/CopyQ/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileType\s*=\s*)('.*')"   = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate {
    function readme2desc() {
        Write-Host 'Setting README.md to Nuspec description tag'
        $description = gc $PSScriptRoot\README.md  | select -Skip 2 | Out-String

        $nuspecPath = "$PSScriptRoot\$($Latest.PackageName).nuspec"
        $nu = gc $nuspecPath -Raw -Encoding UTF8
        $nu = $nu -replace "(?smi)(\<description\>).*?(\</description\>)", "`${1}$($description)`$2"

        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
        [System.IO.File]::WriteAllText($NuspecPath, $nu, $Utf8NoBomEncoding)
    }

    readme2desc
    Get-RemoteFiles -Purge
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "copyq-.*-setup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = 'https://github.com' + $url

    $version = $url -split '-|.exe' | select -Last 1 -Skip 2

    return @{
        URL32        = $url
        Version      = $version.Replace('v','')
        ReleaseNotes = "$releases/tag/${version}"
    }
}

update -ChecksumFor none
