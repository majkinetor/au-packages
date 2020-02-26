import-module au

$releases = 'http://www.foobar2000.org/encoderpack'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"        = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"    = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate {  Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $domain  = $releases -split '(?<=//.+)/' | select -First 1
    $version = $url -split "_Pack-|$re" | select -Last 1 -Skip 1
    $url     = $domain + $url
    @{
        Version  = $version.Replace("-", ".")
        URL32    = $url.Replace("/getfile/", "/files/")
    }
}

update -ChecksumFor none 
