import-module au

$releases = ''

function global:au_SearchReplace {
     @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = ''
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '[._-]|.exe' | select -Last 1 -Skip 2

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
