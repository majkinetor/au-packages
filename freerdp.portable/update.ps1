import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/FreeRDP/FreeRDP'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate {
     Get-RemoteFiles -Purge -NoSuffix
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'freerdp[^/]*\.zip$'
    $version = $url -split '/' | select -Last 1 -Skip 1


    return @{
        Version      = $version
        URL64        = 'https://ci.freerdp.com/job/freerdp-nightly-windows/arch=win64,label=vs2013/lastSuccessfulBuild/artifact/build/Release/wfreerdp.exe'
        ReleaseNotes = "$GitHubRepositoryUrl/releases/tag/$version"
    }
}

update -ChecksumFor none
