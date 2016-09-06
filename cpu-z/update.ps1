import-module au

$releases = 'http://www.cpuid.com/softwares/cpu-z.htm'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
        }
    }
}

function global:au_GetLatest {
    $re      = 'cpu-z.+exe'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $version = $url -split '[_-]' | select -Last 1 -Skip 1

    return @{ URL = $url; Version = $version }
}

update -ChecksumFor none
