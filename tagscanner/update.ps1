import-module au

$releases = 'https://www.xdlab.ru/en/download.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $re       = '\.exe$'
    $url      = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version  = $url -split '-' | select -Last 1 -Skip 1

    @{
        Version      = $version
        URL32        = "https://www.xdlab.ru/$url"
    }
}

update -ChecksumFor none
