# Without the Referer header set to downloads page Get-ChocolateyWebFile will fail
#  and since it doesn't allow setting headers in parameters I need custom downloader
$url = "http://launcher.nirsoft.net/download.html"
$client = New-Object System.Net.WebClient
if (!$client.Proxy.IsBypassed($url)) {
    $creds = [Net.CredentialCache]::DefaultCredentials
    $proxyAddress = $client.Proxy.GetProxy($url).Authority
    Write-Host "Using this proxyserver: $proxyAddress"
}

$params = @{
    Uri     = $url
    Headers = @{ Referer = 'http://launcher.nirsoft.net/download.html' }
}
if ($proxyAddress) {$params.Proxy = $proxyAddress }
if ($creds -and !($creds.Username -eq '')) { $params.ProxyCredential = $creds }

$packageName   = 'nirlauncher'
$download_page = Invoke-WebRequest @params
$url           = $download_page.links | ? href -match "nirsoft_package_.*.zip" | select -First 1 -expand href
$version       = $url -split '_|.zip' | select -Last 1 -Skip 1
$installDir    = Split-Path -parent $MyInvocation.MyCommand.Definition
$zipPath       = "$installDir\$packageName_$version.zip"

Write-Host "Downloading $packageName $version ..."
$params.Uri = $url
$params.OutFile = $zipPath
Invoke-WebRequest @params

Write-Host "Installing $packageName $version and adding it to the PATH"
Write-Host "Local path: $installDir"
Install-ChocolateyZipPackage $packageName $zipPath $installDir
