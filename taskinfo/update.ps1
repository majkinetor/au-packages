. ../au.ps1

$releases = ''

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $reExe    = ''
    $download_page = Invoke-WebRequest -Uri $releases
    $url      = $download_page.links | ? href -match $reExe | select -First 1 -expand href
    #$version  = $url -split '[.-_]|.exe' | select -Last 1 -Skip 2


    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
