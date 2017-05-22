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
  url            = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.2.0/binaries/gitlab-ci-multi-runner-windows-386.exe'
  url64Bit       = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.2.0/binaries/gitlab-ci-multi-runner-windows-amd64.exe'
  checksum       = '6ffe21b68e4cf098d6c464db5d0bbe85313c7803adcd66ae562fca6f104d55f5'
  checksum64     = 'e918773814a71dd8e62b450d0c028cff89155f715219a5eda5d1feb0725ddcbb'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

Get-Service gitlab-runner -ea 0 | Stop-Service
mkdir $pp.InstallDir -ea 0 | Out-Null
cp $tmp_path, $toolsPath\register_example.ps1 $pp.InstallDir -force

$runner_path = $pp.InstallDir + '\gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path
