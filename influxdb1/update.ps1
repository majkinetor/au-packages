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
    $re      = 'influxdb-.+?_windows_amd64.zip$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '-|_' | select -Last 1 -Skip 2

    return @{
        Version      = $version
        URL64        = $url
        ReleaseNotes = "$releases/tag/v$version"
    }
}

if ($MyInvocation.InvocationName -notin '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
