import-module au

$releases = 'http://www.exactaudiocopy.de/en/index.php/weitere-seiten/download-from-alternative-servers-2'

function global:au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = "eac.*\.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '-|/|.exe' | select -Last 1 -Skip 1

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
