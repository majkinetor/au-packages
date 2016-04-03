import-module au

$releases = 'http://smplayer.sourceforge.net/en/downloads'

function global:au_SearchReplace {
    throw 'notify about update'
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = 'smplayer-.+\.exe$'
    $url = $download_page.links | ? href -match $re | select -expand href
    $url32 = $url[0]
    $url64 = $url[1]

    $version  = $url64 -split '-' | select -Last 1 -Skip 1

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version }
    return $Latest
}

update -NoCheck
