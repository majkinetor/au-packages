import-module au

$releases = 'http://www.fosshub.com/SMPlayer.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = 'smplayer-.+\.exe$'
    $url = $download_page.links | ? href -match $re | select -expand href
    $url32 = 'http://www.fosshub.com' + $url[0]
    $url64 = 'http://www.fosshub.com' + $url[1]

    $version  = $url64 -split '-' | select -Last 1 -Skip 1

    $sha = $download_page.RawContent -split "`n" | sls 'SHA256'
    $sha32 = $sha[0].ToString() -split ' |<' | select -Skip 1 -Last 1
    $sha64 = $sha[1].ToString() -split ' |<' | select -Skip 1 -Last 1

    $Latest = @{ URL32 = $url32; URL64 = $url64; Version = $version; Checksum32 = $sha32; Checksum64 = $sha64 }
    return $Latest
}

update -NoCheckUrl
