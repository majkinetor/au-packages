import-module au

$releases = 'https://github.com/hluk/CopyQ/releases'

function global:au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "copyq-.*-setup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = 'https://github.com' + $url

    $version = $url -split '-|.exe' | select -Last 1 -Skip 2

    $Latest = @{ URL = $url; Version = $version }
    throw dummy
    return $Latest
}

update
