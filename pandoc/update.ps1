import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://github.com/jgm/pandoc/releases'

function global:au_SearchReplace() {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest() {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '/pandoc-(.+?)-windows.msi'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $Matches[1] -replace '-.+$'
    @{
        URL32        = 'https://github.com' + $url
        Version      = $version
        ReleaseNotes = "https://github.com/jgm/pandoc/releases/tag/${version}"
    }
}


update -ChecksumFor none
