import-module au

$releases = 'http://www.mls-software.com/opensshd.html'

function global:au_SearchReplace {
     @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
        }
    }}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'setupssh'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $url     = 'http://www.mls-software.com/' + $url
    $version = ($url -split 'setupssh-|.exe' | select -Last 1 -Skip 1) -replace 'p|-','.' -replace '\.v.'

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
