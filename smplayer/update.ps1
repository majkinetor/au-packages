import-module au

$releases = 'https://sourceforge.net/projects/smplayer/files/SMPlayer'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }

        ".\legal\verification.txt" = @{
          "(?i)(\s+x32:).*"        = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"        = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"    = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameSkip 1 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.links | ? { [version]::TryParse($_.innerText, [ref]($__)) } | select -First 1    

    $releases = 'https://sourceforge.net' + $url.href
    $download_page = Invoke-WebRequest -Uri $releases

    @{
        URL32    = $download_page.links | ? href -match '-win32\.exe/download' | % href
        URL64    = $download_page.links | ? href -match '-x64\.exe/download' | % href
        Version  = $url.innerText
        FileType = 'exe'
    }
}

update -ChecksumFor none
