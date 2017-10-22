import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases    = 'https://www.oo-software.com/en/shutup10'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate {
    mkdir $PSScriptRoot\tools -ea 0 | out-null
    Get-RemoteFiles -Purge
    mv $PSScriptRoot\tools\*.exe $PSScriptRoot\tools\OOSU10.exe
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = '\.exe$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version = $download_page.AllElements | ? { $_.InnerText -like 'Version *' } | select -Expand InnerText -First 1
    $version -match "Version ([0-9.]+)" | Out-Null
    @{
        URL32        = $url
        Version      = $Matches[1]
    }
}

update -ChecksumFor none
