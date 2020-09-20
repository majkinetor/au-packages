import-module au

$releases = 'https://github.com/winsw/winsw/releases'

function global:au_SearchReplace {
   @{

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = 'WinSW\..+\.zip$'
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $url     = $download_page.links | ? href -match $re | select -expand href -First 2 | % { $domain + $_ }
    $version = $url[0] -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version.Substring(1) -replace '(?<=-.+)\.'
        URL32        = $url -like '*.x86.*' | select -First 1
        URL64        = $url -notlike '*.x86.*' | select -First 1
        ReleaseNotes = "https://github.com/winsw/winsw/releases/tag/$version"
    }
}

update -ChecksumFor none
