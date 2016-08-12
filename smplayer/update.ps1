import-module au

$releases = 'http://smplayer.sourceforge.net/en/downloads'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = 'smplayer-.+\.exe$'
    $url     = $download_page.links | ? href -match $re | select -expand href
    $url32   = $url[0] -replace '^http://', 'https://'
    $url64   = $url[1] -replace '^http://', 'https://'
    $version = $url64 -split '-' | select -Last 1 -Skip 1

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -Force
