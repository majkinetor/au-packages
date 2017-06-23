import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = "http://launcher.nirsoft.net/downloads/index.html"

function global:au_SearchReplace() {
  @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($global:Latest.URL)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($global:Latest.Checksum32)'"
        }
    }
}
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2}

function global:au_GetLatest() {
    $download_page = Invoke-WebRequest $releases -UseBasicParsing
    $url     = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
    $version = $url -split '_|.zip' | select -Last 1 -Skip 1

    @{ Version = $version; URL = $url }
}

update -ChecksumFor 32 -NoCheckUrl
