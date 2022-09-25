import-module au

$releases = 'https://github.com/doublecmd/doublecmd/releases'

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
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $re      = 'doublecmd-([0-9.]+).x86_64-win64-qt5.dark.7z'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $Matches[1]

    @{
        Version      = $version
        URL32        = $domain + $url
        ReleaseNotes = "https://github.com/doublecmd/doublecmd/releases/tag/v$version"
    }
}

update -ChecksumFor none
