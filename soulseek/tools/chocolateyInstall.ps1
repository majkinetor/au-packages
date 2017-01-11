$ErrorActionPreference = 'Stop'

function download-dropbox($Url, $FilePath) {
    $wc = New-Object system.net.webclient
    $req = [System.Net.HttpWebRequest]::Create($Url)
    $req.CookieContainer  = New-Object System.Net.CookieContainer
    $res = $req.GetResponse()

    $cookies = $res.Cookies | % { $_.ToString()}
    $cookies = $cookies -join '; '

    $wc.Headers.Add([System.Net.HttpRequestHeader]::Cookie, $cookies)
    $newurl = $url + '?dl=1'

    mkdir (Split-Path $FilePath) -force -ea 0 | out-null
    $wc.downloadFile($newurl, $tempFile)
}

$packageName  = 'soulseek'
$url32        = 'https://www.dropbox.com/s/adivgmpo08pgq13/SoulseekQt-2016-4-24.exe'
$checksum32   = ''

$chocoTempDir = Join-Path $Env:Temp "chocolatey"
$tempFile     = "$chocoTempDir\soulseek\soulseek.exe"
download-dropbox $url32 $tempFile

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $tempFile
  checksum               = $checksum32
  checksumType           = 'SHA256'
  silentArgs             = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$installLocation = Get-AppInstallLocation $packageArgs.registryUninstallerKey
if ($installLocation)  { Write-Host "$packageName installed to '$installLocation'" }
else { Write-Warning "Can't find $PackageName install location" }
