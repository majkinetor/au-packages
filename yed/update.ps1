import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://www.yworks.com/products/yed/download'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.RawContent -match 'resources/yed/demo/.+\.zip')
    {
        $url = "https://www.yworks.com/" + $Matches[0]
    }

    #$url = "https://www.yworks.com/resources/yed/demo/yEd-3.14.4.zip"
    $version  = $url -split '[_-]|.zip' | select -Last 1 -Skip 1

    return @{ URL = $url; Version = $version }
}

update -ChecksumFor 64
