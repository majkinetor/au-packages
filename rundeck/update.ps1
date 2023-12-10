import-module au

$releases = 'https://packagecloud.io/pagerduty/rundeck'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }

        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)([$]url\s*=\s*').*'"        = "`${1}$($Latest.URL32)'"
            "(?i)([$]checksum32\s*=\s*').*'" = "`${1}$($Latest.Checksum32)'"
        }
    }
}

function global:au_BeforeUpdate { $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 }

function global:au_GetLatest {
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    # https://packagecloud.io/pagerduty/rundeck/packages/java/org.rundeck/rundeck-4.17.0-20230925.war/artifacts/rundeck-4.17.0-20230925.war
    $versionUrl = $download_page.Links | ? title -like '*.war' | select -First 1 | % href
    $versionUrl = $domain + $versionUrl

    $download_page = Invoke-WebRequest -Uri $versionUrl -UseBasicParsing
    $url = $download_page.Links | ? href -like "*.war/download" | select -First 1 | % href

    $version = $url -split '.+rundeck-|-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = $url
        FileType     = 'war'
    }
}

update -ChecksumFor none
