. ../au.ps1

$releases = 'http://www.exactaudiocopy.de/en/index.php/weitere-seiten/download-from-alternative-servers-2'

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url      = $download_page.links | ? href -match "eac.*\.exe" | select -First 1 -expand href
    $version  = $url -split '-|/|.exe' | select -Last 1 -Skip 1

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
