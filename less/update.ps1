import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/jftuga/less-Windows'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'less\.exe$'
    $version =  ($url -split '/'| select -last 1 -Skip 1) -replace 'less-v'
    $x = ''
    if ([int]::TryParse($version, [ref] $x)) { $version = "$version.0" }
    if ($version.Length -eq 3) { $version += "0" }

    return @{
        Version      = $version -replace '^v'
        URL64        = $url
        ReleaseNotes = "http://www.greenwoodsoftware.com/less/news.$version.html"
    }
}

update -ChecksumFor none