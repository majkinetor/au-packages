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
    Write-Host 'Using install directory:'  $pp.InstallDir
}

$tmp_path = Join-Path (Get-PackageCacheLocation)  "gitlab-runner.exe"
$packageArgs = @{
  packageName    = 'gitlab-runner'
  fileFullPath   = $tmp_path
  url            = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.0.0/binaries/gitlab-ci-multi-runner-windows-386.exe'
  url64Bit       = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.0.0/binaries/gitlab-ci-multi-runner-windows-amd64.exe'
  checksum       = '4db91d8cc4ddf5804db2fa18a31602bd9d904e990f2e05b5d1b1d47084e33f4b'
  checksum64     = '3f8ea3a121f6366d510f4864ed0ca332a22f1bddafffad633e13353abee3a52a'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-Service gitlab-runner -ea 0 | Stop-Service
mkdir $pp.InstallDir -ea 0 | Out-Null
cp $tmp_path $pp.InstallDir -force
