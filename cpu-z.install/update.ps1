import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'http://www.cpuid.com/softwares/cpu-z.htm'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $re = 'cpu-z.+exe'

    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $url = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $current_checksum = (gi $PSScriptRoot\tools\chocolateyInstall.ps1 | sls '\bchecksum\b') -split "=|'" | Select -Last 1 -Skip 1
    $remote_checksum  = Get-RemoteChecksum $url
    if ($current_checksum -ne $remote_checksum) {
        Write-Host 'Remote checksum is different then the current one, forcing update'
        $global:au_old_force = $global:au_force
        $global:au_force = $true
    }

    @{
        Version = $url -split '[_-]' | select -Last 1 -Skip 1
        URL32   = $url
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor 32
    if ($global:au_old_force -is [bool]) { $global:au_force = $global:au_old_force }
}
