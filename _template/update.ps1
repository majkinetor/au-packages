. ../au.ps1

$releases = ''

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = ''
    $url   = $download_page.links | ? href -match $reExe | select -First 1 -expand href
    if (!$url) { throw "Can't match any url using '$re'" }

    $re      = "^[\d.]+$"
    $version  = $url -split '[._-]|.exe' | select -Last 1 -Skip 2
    if ($version -notmatch $re) { throw "Can't match version using '$re': $version" }

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
