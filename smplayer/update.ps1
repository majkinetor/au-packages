import-module au

$releases = 'https://sourceforge.net/projects/smplayer/files/SMPlayer'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }

        ".\tools\verification.txt" = @{
          "(?i)(\s+x32:).*"        = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"        = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"    = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
    $toolsPath = "$PSScriptRoot\tools"

    rm "$toolsPath\*.exe" -force -ea stop
    $client = New-Object System.Net.WebClient
        $fn = $latest.url32 -split '/' | select -Last 1 -Skip 1
        Write-Host 'Downloading x32 installer: ' $fn
        $client.DownloadFile($Latest.Url32, "$toolsPath\$fn")
        $Latest.Checksum32 = Get-FileHash -Algorithm SHA256 -Path "$toolsPath\$fn" | % Hash

        $fn = $latest.url64 -split '/' | select -Last 1 -Skip 1
        Write-Host 'Downloading x64 installer: ' $fn
        $client.DownloadFile($Latest.Url64, "$toolsPath\$fn")
        $Latest.Checksum64 = Get-FileHash -Algorithm SHA256 -Path "$toolsPath\$fn" | % Hash
    $client.Dispose()
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.links | ? { [version]::TryParse($_.innerText, [ref]($__)) } | select -First 1

    $releases = 'https://sourceforge.net' + $url.href
    $download_page = Invoke-WebRequest -Uri $releases

    @{
        URL32    = $download_page.links | ? href -match '-win32\.exe/download' | % href
        URL64    = $download_page.links | ? href -match '-x64\.exe/download' | % href
        Version  = $url.innerText
    }
}


try {
    update -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignored) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
