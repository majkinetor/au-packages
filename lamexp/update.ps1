import-module au

$releases = 'https://github.com/lordmulder/LameXP/releases'

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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $release = $url -split '/' | select -last 1 -skip 1
    $version = $release.Replace('Release_','') -replace '^.', '$0.'
    @{
        Version      = $version
        URL32        = 'https://github.com/' + $url
        ReleaseNotes = "https://github.com/lordmulder/LameXP/releases/tag/$release"
    }
}

update -ChecksumFor none
