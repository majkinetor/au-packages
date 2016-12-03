import-module au

$releases = 'https://sourceforge.net/projects/smplayer/files/SMPlayer'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url = $download_page.links | ? { [version]::TryParse($_.innerText, [ref]($__)) } | select -First 1

    $releases = 'https://sourceforge.net' + $url.href
    $download_page = Invoke-WebRequest -Uri $releases

    @{
        URL32   = $download_page.links | ? href -match '-win32\.exe/download' | % href
        URL64   = $download_page.links | ? href -match '-x64\.exe/download' | % href
        Version = $url.innerText
    }
}

update
