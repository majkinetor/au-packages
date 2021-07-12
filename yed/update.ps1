import-module au
$ErrorActionPreference = 'STOP'

$releases = 'https://www.yworks.com/products/yed/download'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_BeforeUpdate  { $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.RawContent -match 'resources/yed/demo/yEd.+?\.exe')
    {
        $url = "https://www.yworks.com/" + $Matches[0]
    } else { throw "Can't find url" }

    #$url = "https://www.yworks.com/resources/yed/demo/yEd-3.14.4.zip"
    #https://www.yworks.com/resources/yed/demo/yEd-3.21.1_with-JRE15_64-bit_setup.exe

    $version  = $url -split '[_-]|.zip' | select -First 1 -Skip 1

    @{
        Version = $version
        URL32   = "https://www.yworks.com/resources/yed/demo/yEd-$version.zip"
    }
}

update -ChecksumFor none
