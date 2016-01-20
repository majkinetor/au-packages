$releases = 'https://github.com/dnGrep/dnGrep/releases'

function SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
        }
     }
}

function GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url      = $download_page.links | ? href -match "dnGREP.*.msi" | select -First 2 -expand href
    $version  = $url -split '-|.exe' | select -Last 1 -Skip 2

    $url64    = 'https://github.com' + $url[0]
    $url32    = 'https://github.com' + $url[1]

    $Latest = @{ URL64 = $url64; URL32 = $url32; Version = $version }
    return $Latest
}

