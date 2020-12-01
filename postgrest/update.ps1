import-module au

$releases = 'https://github.com/PostgREST/postgrest/releases/latest'

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

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = 'windows-x64\.zip$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $version = $url -split '/' | select -Last 1 -Skip 1
    if ($version -eq 'nightly') { Write-Host "Nightly release is the latest"; return 'ignore' }

    @{
        Version      = $version.SubString(1)
        URL64        = $domain + $url
        ReleaseNotes = "https://github.com/PostgREST/postgrest/releases/tag/$version"
    }
}

update -ChecksumFor none
