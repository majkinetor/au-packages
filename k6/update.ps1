import-module au

$releases = 'https://github.com/loadimpact/k6/releases'

function global:au_SearchReplace {
   @{

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'win\d\d\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 2 -expand href | % { 'https://github.com' + $_}

    $version  = $url -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version.Substring(1)
        URL32        = $url -match 'win32' | select -First 1
        URL64        = $url -match 'win64' | select -First 1
        ReleaseNotes = "https://github.com/loadimpact/k6/releases/tag/${version}"
    }
}

update -ChecksumFor none
