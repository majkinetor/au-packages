import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://supportcenter.checkpoint.com/supportcenter/portal/role/supportcenterUser/page/default.psml/media-type/html?action=portlets.DCFileAction&eventSubmit_doGetdcdetails=&fileid=100238'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '\.msi'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $url -split '/|_CheckPoint' | select -Last 1 -Skip 1
    $letter  = $version.Substring(0,1)
    $version = $version.Substring(1)

    @{
        Version  = ([int][char]$letter - ([int][char]'A') + 1).ToString() + '.' + $version
        URL32    = $url
    }
}

update
