import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/dnGrep/dnGrep'

function global:au_SearchReplace {
    @{
       ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
     }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'dnGREP.*.msi'
    $version = $url[0] -split '/' | select -Last 1 -Skip 1

    return @{
        Version      = $version.Substring(1)
        URL32        = $url -match 'x86' | Select-Object -First 1
        URL64        = $url -match 'x64' | Select-Object -First 1
        ReleaseNotes = "$GitHubRepositoryUrl/releases/tag/$version"
    }
}

update -ChecksumFor none
