import-module au

$releases = 'http://wkhtmltopdf.org/downloads.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $re    = 'wkhtmltox-.*\.exe'

    $url   = $download_page.links | ? href -match $re | select -First 2 -expand href
    $url32 = $url[0]; $url64 = $url[1]
    $version  = $url32 -split  '[-_]' | select -Last 1 -Skip 2

    $Latest = @{ URL64 = $url64; URL32 = $url32; Version = $version }
    return $Latest
}

update
