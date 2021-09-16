import-module au

$releases = 'http://www.ximple.cz/download.php'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase XiMpLe
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = 'pickup.4'
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $download_page.content -match "XiMpLe version ([\d.]+)"
    $version = $Matches[1]

    @{
        Version      = $version
        URL32        = $url | ? { $_ -like '*t=32*' } | select -First 1
        URL64        = $url | ? { $_ -like '*t=64*' } | select -First 1
        FileType     = 'exe'
    }
}

update -ChecksumFor none -NoCheckUrl
