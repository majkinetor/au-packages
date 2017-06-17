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
  url            = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.2.1/binaries/gitlab-ci-multi-runner-windows-386.exe'
  url64Bit       = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.2.1/binaries/gitlab-ci-multi-runner-windows-amd64.exe'
  checksum       = 'db6acc99ad96362dbde896d75fa2a397580a1f69e87b1a2e6bae489e353004cf'
  checksum64     = '42a69d16c341001a512e286bbaf51001895396c5ceb968dda945178139117b3d'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-Service gitlab-runner -ea 0 | Stop-Service
mkdir $pp.InstallDir -ea 0 | Out-Null
cp $tmp_path, $toolsPath\register_example.ps1 $pp.InstallDir -force

$runner_path = $pp.InstallDir + '\gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path
