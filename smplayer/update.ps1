import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = "https://github.com/smplayer-dev/smplayer"

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
        }

        ".\legal\verification.txt" = @{
          "(?i)(\s+x64:).*"        = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"    = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'smplayer-.+-x64-unsigned\.exe$' | select -Last 1
    $version = $url -split '/' | select -Last 1 -Skip 1
    @{
        Version = $version.Substring(1)
        URL64   = $url
    }
}

update -ChecksumFor none
