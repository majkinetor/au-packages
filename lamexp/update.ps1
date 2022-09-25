import-module au

$GitHubRepositoryUrl = 'https://github.com/lordmulder/LameXP'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl
    $release = $url -split '/' | select -last 1 -skip 1
    $version = $release.Replace('Release_','') -replace '^.', '$0.'

    return @{
        Version      = $version
        URL32        = $url
        ReleaseNotes = "$GitHubRepositoryUrl/releases/tag/$release"
    }
}


update -ChecksumFor none
