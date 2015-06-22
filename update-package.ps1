param([switch] $Push )

function Load-NuspecFile() {
    $nu = New-Object xml
    $nu.psbase.PreserveWhitespace = $true
    $nu.Load($nuspecFile)
    $nu
}

function Get-Proxy() {
    $params = @{}

    $client = New-Object System.Net.WebClient
    $testUrl = 'http:\\www.google.com'
    if (!$client.Proxy.IsBypassed($testUrl)) {
        $creds = [Net.CredentialCache]::DefaultCredentials
        $proxyAddress = $client.Proxy.GetProxy($testUrl).Authority
        Write-Host "Using this proxyserver: $proxyAddress"
    }

    if ($proxyAddress) {$params.Proxy = 'http://' + $proxyAddress }
    if ($creds -and !($creds.Username -eq '')) { $params.ProxyCredential = $creds }
    $params
}

$nuspecFile = gi *.nuspec
if (!$nuspecFile) {throw "No nuspec file" }
if ($nuspecFile -is [array]) { throw "There is more then one .nuspec file" }

$iwrProxy = Get-Proxy
$nu       = Load-NuspecFile

"Checking package"

$remote_version       = Get-Latest
$repository_version   = $nu.package.metadata.version

"Repository version: $repository_version"
"Remote version:     $remote_version"

if (!$remote_version) { throw "Invalid version: '$remote_version'" }
if ($remote_version -eq $repository_version) { "No new version found"; return }

"Updating files: "
"|- $nuspecFile"
$nu.package.metadata.version = "$remote_version"
$nu.Save($nuspecFile)

Get-FileReplace | % {
    "|- {0} : {1} {2} " -f $_.Key, $_.Value[0], $_.Value[1]
    $c = (gc $_.Key) -replace $_.Value[0],$_.Value[1]
    $c | out-file -Encoding UTF8 $_.Key
}

"Package updated"

if (!$Push) { return }

"Pushing package to chocolatey"
rm *.nupkg
cpack
..\push.ps1
