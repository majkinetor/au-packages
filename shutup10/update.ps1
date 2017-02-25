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

    $re = '\.exe$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    Write-Host $url

    $version = $download_page.AllElements | ? {$_.TagName -eq 'h4' -and $_.InnerText -like 'Version *'} | select -Expand InnerText -First 1 | % { $_ -replace 'Version ' }

    @{
        URL32        = $url
        Version      = $version.Replace('v','')
    }
}

try {
    update -ChecksumFor none
} catch {
    $ignore = "The specified API key does not provide the authority to push packages"
    if ($_ -match $ignore) { Write-Host $ignore; 'ignore' } else { throw $_ }
}
