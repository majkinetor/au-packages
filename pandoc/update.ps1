. ../au.ps1

$releases = 'https://github.com/jgm/pandoc/releases'
$name_re  = '/pandoc-(.+?)-windows.msi'

function au_GetLatest() {
    $download_page = Invoke-WebRequest -Uri $releases
    $url           = $download_page.links | ? href -match $name_re | select -First 1 -expand href
    $version       = $Matches[1]

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
