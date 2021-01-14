import-module au

$releases = 'http://wkhtmltopdf.org/downloads.html'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re      = 'wkhtmltox-.*\.exe'
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href

    $version = $url[0] -split  '[-_]' | select -Last 1 -Skip 2

    @{
        Version = $version
        URL32 = $url | ? { $_ -match '-win32' } | select -First 1
        URL64 = $url | ? { $_ -match '-win64' } | select -First 1
    }
}

update -ChecksumFor none
