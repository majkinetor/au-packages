. ../au.ps1

$releases = 'https://github.com/jgm/pandoc/releases'

function au_GetLatest() {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = '/pandoc-(.+?)-windows.msi'
    $url = $download_page.links | ? href -match $name_re | select -First 1 -expand href
    if (!$url) { throw "Can't match any url using '$re'" }

    $re      = "^[\d.]+$"
    $version = $Matches[1]
    if ($version -notmatch $re) { throw "Can't match version using '$re': $version" }

    $url    = 'https://github.com' + $url

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

function au_SearchReplace() {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')" =  "`$1'$($Latest.URL)'"
        }
    }
}

update
