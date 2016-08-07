import-module au

$changelog = 'http://www.soulseekqt.net/news/changelog'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" 
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $changelog

    $url     = $download_page.links | ? href -like '*.exe*' | select -First 1 -expand href
    $version = $url -split '-|\.' | select -Last 3 -Skip 1
    $version = $version -join '.'
    $url     = $url -replace '\?.+'

    return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32
