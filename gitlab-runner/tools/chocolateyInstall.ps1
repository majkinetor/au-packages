$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$current_dir = Get-RunnerInstallDir

if ($current_dir) {
    Write-Host 'Using previous gitlab-runner install path:' $current_dir
    $pp.InstallDir = $current_dir
} else {
    if (!$pp.InstallDir) { $pp.InstallDir = "C:\GitLab-Runner" }
    Write-Host 'Using install directory:' $pp.InstallDir
}

$tmp_path = Join-Path (Get-PackageCacheLocation)  "gitlab-runner.exe"
$packageArgs = @{
  packageName    = 'gitlab-runner'
  fileFullPath   = $tmp_path
  url            = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.0/binaries/gitlab-ci-multi-runner-windows-386.exe'
  url64Bit       = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.1.0/binaries/gitlab-ci-multi-runner-windows-amd64.exe'
  checksum       = '22f3878a22c20ba620a0c18dcb98270c2b01bfab3cf31cda07b6137a78c6b6b9'
  checksum64     = 'bee2dbb9ed256765dcd7638f14c371b120eb635b570a842ab1f911e5e4b1552d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-Service gitlab-runner -ea 0 | Stop-Service
mkdir $pp.InstallDir -ea 0 | Out-Null
cp $tmp_path, $toolsPath\register_example.ps1 $pp.InstallDir -force

$runner_path = $pp.InstallDir + '\gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path
