import-module au

$releases = 'https://github.com/jgm/pandoc/releases/latest'

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
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest() {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '/pandoc-(.+?)-windows-.*.msi'
    [array] $url  = $download_page.links | ? href -match $re | select -First 2 -expand href
    $version = $url[0] -split '/' | select -last 1 -skip 1
    @{
        #URL32        = 'https://github.com' + ($url -match 'i386' | select -first 1)
        URL64        = 'https://github.com' + ($url -notmatch 'i386' | select -first 1)
        Version      = $version
        ReleaseNotes = "https://github.com/jgm/pandoc/releases/tag/${version}"
    }
}


update -ChecksumFor none
