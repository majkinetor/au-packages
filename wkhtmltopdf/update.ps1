import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'http://wkhtmltopdf.org/downloads.html'

function global:au_SearchReplace {
    @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    $re      = 'wkhtmltox-.*\.exe'
    $url     = $download_page.links | ? href -match $re | select -First 2 -expand href
    $url32   = $url[0]; $url64 = $url[1]
    $version = $url32 -split  '[-_]' | select -Last 1 -Skip 2

    return @{ URL64 = $url64; URL32 = $url32; Version = $version }
}

update -ChecksumFor none
