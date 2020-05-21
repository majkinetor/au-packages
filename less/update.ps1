import-module au

$releases = 'https://github.com/jftuga/less-Windows/releases/latest'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"      = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"  = "`${1} $($Latest.Checksum32)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate {   
    Get-RemoteFiles -Purge -NoSuffix 
 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $re  = 'less\.exe$'
    $url = $download_page.links | ? href -match $re | % href | select -first 1
    $version =  ($url -split '/'| select -last 1 -Skip 1) -replace 'less-v' -replace '\.0'
    $version = "$($version / 100)"  # using string interpolation here to force the invariant rather than the current culture
    if ($version.Length -eq 3) { $version += "0" }

    @{
       URL32 = $domain + $url
       Version = $version
       ReleaseNotes = "http://www.greenwoodsoftware.com/less/news.$version.html"
    }
}


update -ChecksumFor none