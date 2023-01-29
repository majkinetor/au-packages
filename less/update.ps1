import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/jftuga/less-Windows'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"      = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"  = "`${1} $($Latest.Checksum64)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

   Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
   7z e tools\*.zip -otools *.exe -r -y
   rm tools\*.zip -ea 0
}


function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'less-x64\.zip$'
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