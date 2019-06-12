import-module au

$releases = 'https://portal.influxdata.com/downloads'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = 'influxdb-[0-9.]+.+_windows_amd64\.zip'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '-|_' | ? { try { [version]::Parse($_) } catch {} }

    @{
        Version = $version
        URL64   = $url
    }
}

update -ChecksumFor none
