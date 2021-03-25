import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/hunterlong/statping/releases/latest'

function global:au_SearchReplace {
   @{

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -NoSuffix

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe

    $filePath = gi $PSScriptRoot\tools\statping*.zip
    7z x $filePath -otools -aoa
    rm $filePath
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '/|\.zip' | select -Last 1 -Skip 1

    @{
        Version      = $version.Substring(1)
        URL64        = "https://github.com/$url"
        ReleaseNotes = "https://github.com/hunterlong/statping/releases/tag/$version"
    }
}

update -ChecksumFor none
