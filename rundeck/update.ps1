import-module au

$releases = 'https://docs.rundeck.com/downloads.html'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
            "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
            "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'rundeck-([\d.]+)-.+\.war'
    $download_page.content -match $re | Out-Null
    $name = $Matches[0];  $version = $Matches[1]
    $release_notes = $download_page.links | ? class -eq 'rd_releasenotes' | select -First 1 | % href
    @{
        Version = $version
        URL32   = "https://dl.bintray.com/rundeck/rundeck-maven/org/rundeck/rundeck/$name"
        ReleaseNotes = $release_notes
    }
}

update -ChecksumFor none
