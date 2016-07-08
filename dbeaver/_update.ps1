import-module au

$releases = 'https://github.com/serge-rider/dbeaver/releases'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re  = "setup.exe"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url32 = 'https://github.com' + $url
    $url64 = $url32 -replace '-x86-', '-x86_64-'

    $version = $url -split '-' | select -Last 1 -Skip 2

    $Latest = @{ URL64 = $url64; URL32 = $url32; Version = $version }
    return $Latest
}

update
