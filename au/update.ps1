import-module au

$releases = 'https://github.com/majkinetor/au/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '.+\.zip'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url     = 'https://github.com' + $url
    $version = $url -split '/|\.zip' | select -Last 1 -Skip 1

    return @{ URL32 = $url; Version = $version }
}

update -ChecksumFor 32
