. ../au.ps1

$releases = 'https://github.com/hluk/CopyQ/releases'

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "copyq-.*-setup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    if (!$url) { throw "Can't match any url using '$re'" }

    $version = $url -split '-|.exe' | select -Last 1 -Skip 2
    $url     = 'https://github.com' + $url

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
