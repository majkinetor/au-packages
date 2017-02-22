import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/serge-rider/dbeaver/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

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
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | select -Expand href -First 2 | % { 'https://github.com' + $_ }

    $version  = $url[0] -split '/' | select -Last 1 -Skip 1

    @{
        Version      = $version
        URL32        = $url | ? {$_ -notmatch 'x86_64'} | select -First 1
        URL64        = $url | ? {$_ -match    'x86_64'} | select -First 1
        ReleaseNotes = "https://github.com/serge-rider/dbeaver/releases/tag/${version}"
    }
}

update -ChecksumFor none
