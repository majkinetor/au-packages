$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName            = $Env:ChocolateyPackageName
  fileType               = 'MSI'
  url                    = 'http://dl3.checkpoint.com/paid/5f/5f8185de35b0cd83fe7480d891fe8df6/E82.00_CheckPointVPN.msi?HashKey=1573560746_011156b7e2a0c68058182c2f9f5b3a6d&xtn=.msi'
  checksum               = '24fb5824d23b59494197214b75309cb58759ea11ac91aea2cf05628ae7ab57af'
  checksumType           = 'sha256'
  silentArgs             = '/q /log "{0}/setup.log"' -f "$Env:TEMP\chocolatey\$Env:ChocolateyPackageName"
  validExitCodes         = @(0, 3010)
  softwareName           = 'Check Point VPN'
}
Install-ChocolateyPackage @packageArgs
