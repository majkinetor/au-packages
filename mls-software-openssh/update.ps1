import-module au

$releases = 'http://www.mls-software.com/opensshd.html'

function global:au_SearchReplace {
     @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($global:Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($global:Latest.Checksum64)'"
        }
    }}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = 'setupssh'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url     = 'https://www.mls-software.com/' + $url
    $version = ($url -split 'setupssh-|.exe' | select -Last 1 -Skip 1) -replace 'p|-','.' -replace '\.v.'

    return @{ URL = $url; Version = $version }
}

update -ChecksumFor 64
