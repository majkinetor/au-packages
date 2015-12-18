$releases = 'https://github.com/hluk/CopyQ/releases'

function Get-Latest() {
    $download_page = Invoke-WebRequest -Uri $releases @iwrProxy
    $global:url    = $download_page.links | ? href -match "copyq-.*-setup.exe" | select -First 1 -expand href
    $version       = $url -split '-|.exe' | select -Last 1 -Skip 2

    $global:url    = 'https://github.com' + $global:url
    $version
}

function Get-FileReplace() {
    $FileReplace = @{
        ".\tools\chocolateyInstall.ps1" = @( "(^[$]url\s*=\s*)('.*')",  "`$1'$URL'" )
    }
    $FileReplace.GetEnumerator()
}

. ../update-package.ps1
