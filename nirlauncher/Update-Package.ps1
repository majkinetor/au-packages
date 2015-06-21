#require 3.0

function Get-Latest() {
    $params = @{
        Uri = "http://launcher.nirsoft.net/download.html"
    }

    $client = New-Object System.Net.WebClient
    if (!$client.Proxy.IsBypassed($params.Uri)) {
        $creds = [Net.CredentialCache]::DefaultCredentials
        $proxyAddress = $client.Proxy.GetProxy($url).Authority
        Write-Host "Using this proxyserver: $proxyAddress"
    }

    if ($proxyAddress) {$params.Proxy = $proxyAddress }
    if ($creds -and !($creds.Username -eq '')) { $params.ProxyCredential = $creds }

    $download_page = Invoke-WebRequest @params
    $url           = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
    $version       = $url -split '_|.zip' | select -Last 1 -Skip 1

    @($version, $url)
}

function Load-NuspecFile() {
    $global:nuspecFile = (gi *.nuspec)
    $nu = New-Object xml
    $nu.psbase.PreserveWhitespace = $true
    $nu.Load($nuspecFile)
    $nu
}

$remote_version, $url = Get-Latest
$nu = Load-NuspecFile

"URL: $url"
"Remote version: $remote_version"
"Repository version: $($nu.package.metadata.version)"

if ($remote_version -ne $nu.package.metadata.version)
{
    "Updating package ..."

    "Updating nuspec version"
    $nu.package.metadata.version = "$remote_version"
    $nu.Save($nuspecFile)

    "Updating chocolateyInstall URL"
    $f = ".\tools\chocolateyInstall.ps1"
    $c = (gc $f) -replace "([$]url\s*=\s*)('.+')", "`$1'$url'"
    $c | out-file -Encoding utf8 $f

    "Package updated"
} else { "No new version found" }

