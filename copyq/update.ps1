. ../au.ps1

$releases = 'https://github.com/hluk/CopyQ/releases'

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url      = $download_page.links | ? href -match "copyq-.*-setup.exe" | select -First 1 -expand href
    $version  = $url -split '-|.exe' | select -Last 1 -Skip 2

    $url    = 'https://github.com' + $url

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
