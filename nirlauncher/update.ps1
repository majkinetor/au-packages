import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = "http://launcher.nirsoft.net/downloads/index.html"

function global:au_SearchReplace() {
  @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
    }
}
function global:au_AfterUpdate  {  Set-DescriptionFromReadme -SkipFirst 2 }
function global:au_BeforeUpdate  { 
    rm tools\*.zip, tools\*.nlp -ea 0
    $name = Split-Path -Leaf $Latest.URL32
    iwr -Headers @{ Referer = $releases } $Latest.URL32 -OutFile tools\$name
    iwr http://download.nirsoft.net/sysinternals2.nlp -OutFile tools\sysinternals2.nlp
}

function global:au_GetLatest() {
    $download_page = Invoke-WebRequest $releases -UseBasicParsing
    $url     = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
    $version = $url -split '_|.zip' | select -Last 1 -Skip 1

    @{ Version = $version; URL32 = $url }
}

update -ChecksumFor none -NoCheckUrl
