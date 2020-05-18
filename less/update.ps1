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

#     add-type @"
#     using System.Net;
#     using System.Security.Cryptography.X509Certificates;
#     public class TrustAllCertsPolicy : ICertificatePolicy {
#         public bool CheckValidationResult(
#             ServicePoint srvPoint, X509Certificate certificate,
#             WebRequest request, int certificateProblem) {
#             return true;
#         }
#     }
# "@
# [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $domain  = $releases -split '(?<=//.+)/' | select -First 1

    $re  = '\.exe$'
    $url = $download_page.links | ? href -match $re | % href
    $version =  ($url[0] -split '/'| select -last 1 -Skip 1) -replace 'less-v' -replace '\.1'
    $version = "$($version / 100)"  # using string interpolation here to force the invariant rather than the current culture
    if ($version.Length -eq 3) { $version += "0" }

    @{
       URL32 = $domain + $url[0]
       URL64 = $domain + $url[1]
       Version = $version
       ReleaseNotes = "http://www.greenwoodsoftware.com/less/news.$version.html"
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
