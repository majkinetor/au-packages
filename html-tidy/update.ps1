import-module au

$releases = 'https://github.com/htacg/tidy-html5/releases'

function global:au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    #tidy-5.1.25-win64.zip
    $re  = "tidy-.+-win(32|64).zip"
    $url = $download_page.links | ? href -match $re | select -First 2 -expand href

    $version = $url[0] -split '-' | select -Last 1 -Skip 1
    $url32 = 'https://github.com' + $url[0]
    $url64 = 'https://github.com' + $url[1]

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update
