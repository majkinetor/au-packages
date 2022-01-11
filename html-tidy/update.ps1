import-module au

$releases = 'https://github.com/htacg/tidy-html5/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $re  = "tidy-([^/]+)-win64.zip$"
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $Matches[1]
    @{
        Version      = $version
        URL64        = $domain + $url
        ReleaseNotes = "http://binaries.html-tidy.org/release_notes/$version.html"
    }
}

update -ChecksumFor none
