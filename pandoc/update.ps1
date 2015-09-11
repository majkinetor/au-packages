param( [switch] $Push )

$releases = 'https://github.com/jgm/pandoc/releases'
$name_re  = '/pandoc-(.+?)-windows.msi'

function Get-Latest() {
    $download_page = Invoke-WebRequest -Uri $releases @iwrProxy
    $global:url    = $download_page.links | ? href -match $name_re | select -First 1 -expand href
    $version       = $Matches[1]

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
