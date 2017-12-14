import-module au

$releases = 'https://www.visualsvn.com/server/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.msi$'
    $download_page.links | ? href -match $re | select -First 2 -expand href
    $version  = $url -split '-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = "https://www.visualsvn.com" + ( $url -match 'win32' | select -first 1)
        URL64        = "https://www.visualsvn.com" + ( $url -notmatch 'win32' | select -first 1)
    }
}

update
