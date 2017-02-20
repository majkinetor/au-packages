import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'http://www.cpuid.com/softwares/cpu-z.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $re      = 'cpu-z.+\.zip'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $version = $url -split '[_-]' | select -Last 1 -Skip 1

    return @{ URL = $url; Version = $version }
}

update -ChecksumFor 32
