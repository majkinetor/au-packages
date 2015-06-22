$releases = "http://launcher.nirsoft.net/download.html"

function Get-Latest() {
    $download_page = Invoke-WebRequest -Uri $releases @iwrProxy
    $global:url    = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
    $version       = $url -split '_|.zip' | select -Last 1 -Skip 1

    $version
}

function Get-FileReplace() {
    $FileReplace = @{
        ".\tools\chocolateyInstall.ps1" = @( "(^[$]url\s*=\s*)('.*')",  "`$1'$URL'" )
    }
    $FileReplace.GetEnumerator()
}

. ../update-package.ps1
