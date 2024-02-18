import-module au

$changelog = 'http://www.soulseekqt.net/news/node/1'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s+url64bit\s*=\s*)('.*')" = "`$1'$($Latest.URL)'"
            "(^\s+checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $changelog

    $url     = $download_page.links | ? href -like '*64bit.exe*' | select -First 1 -expand href
    $version = $url -split '-|\.' | select -Last 3 -Skip 2
    $version = $version -join '.'
    $url     = $url -replace '\?.+'

    return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 64 -Force
