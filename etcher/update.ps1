import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/resin-io/etcher/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_AfterUpdate  {  Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '\.exe$'
    $url   =  $download_page.links | ? href -match $re | select -First 2 |  % { "https://github.com" + $_.href }
    $version  = $url[0] -split '-' | select -last 1 -Skip 2

    @{
        Version      = $version
        URL32        = $url -notmatch 'x64' | select -First 1
        URL64        = $url -match 'x64' | select -First 1
    }
}

update
