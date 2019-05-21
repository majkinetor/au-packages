import-module au

$releases = 'http://www.andre-simon.de/zip/download.php'

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

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'ansifilter.+\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 2 -expand href 
    $version  = $url[0] -split '-|.zip' | select -index 1
    $url = $url | % {'http://www.andre-simon.de/zip/' + $_}

    @{
        Version  = $version
        URL32    =  $url -notmatch 'x64' | select -First 1
        URL64    =  $url -match 'x64' | select -First 1
    }
}

update -ChecksumFor none
