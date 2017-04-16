import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'https://www.powershellgallery.com/packages/InvokeBuild'

function global:au_SearchReplace {
   @{}
}

function global:au_BeforeUpdate {
    rm tools\InvokeBuild -Force -Recurse -ea 0
    Install-PackageProvider Nuget -Force
    Save-Module -Name InvokeBuild -Path tools
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '/Download$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    @{
        Version  = $url -split '/' | select -Last 1 -Skip 1
    }
}

update -NoCheckUrl -ChecksumFor none