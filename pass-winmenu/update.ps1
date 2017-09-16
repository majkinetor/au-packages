import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/Baggykiin/pass-winmenu/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

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
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = 'nogpg\.zip$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $url = "https://github.com" + $url

    $version = $url -split '/' | select -Last 1 -Skip 1
    $version = $version.SubString(1)

    @{
        Version      = $version
        URL32        = $url
        ReleaseNotes = "https://github.com/Baggykiin/pass-winmenu/releases/tag/$version"
    }
}

update -ChecksumFor none
