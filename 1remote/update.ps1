import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/1Remote/1Remote/releases/tag/Nightly'

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
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl '1Remote[^/]+\.zip$' | select -Last 1
    $version = $url -split '-' | select -Last 1 -Skip 1
    $version = "1.0.0.$version"

    return @{
        Version      = $version
        URL64        = $url
    }
}

update -ChecksumFor none
