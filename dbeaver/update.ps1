import-module au

$releases = 'https://github.com/serge-rider/dbeaver/releases'

function global:au_SearchReplace {
    @{}
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "setup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = 'https://github.com' + $url

    $version = $url -split '-' | select -Last 1 -Skip 2

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
