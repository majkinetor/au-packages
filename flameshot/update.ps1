import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/flameshot-org/flameshot'

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

    Set-Alias 7z $Env:chocolateyInstall\tools\7z.exe
    7z e tools\*.zip -otools *.exe -r -y
    rm tools\*.zip -ea 0
}

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl '\.msi$'
    $version = $url -split '/' | select -Last 1 -Skip 1

    return @{
        Version      = $version.Substring(1)
        URL32        = $url
        ReleaseNotes = "$GitHubRepositoryUrl/releases/tag/$version"
    }
}

update -ChecksumFor none
