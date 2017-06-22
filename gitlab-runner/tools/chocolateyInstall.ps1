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

if ($pp.Service -is [string]) { 
    $Username, $Password = $pp.Service -split ':'
    if (!$Password) { throw 'When specifying service user, password is required' } 
}

$tmp_path = Join-Path (Get-PackageCacheLocation)  "gitlab-runner.exe"
$packageArgs = @{
  packageName    = 'gitlab-runner'
  fileFullPath   = $tmp_path
  url            = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.3.0/binaries/gitlab-ci-multi-runner-windows-386.exe'
  url64Bit       = 'https://gitlab-ci-multi-runner-downloads.s3.amazonaws.com/v9.3.0/binaries/gitlab-ci-multi-runner-windows-amd64.exe'
  checksum       = 'e8fd62e426d0ece44d81eeaa8c48bf7a2f2b11eed81aeb1c05f26f6b7bc4bab5'
  checksum64     = '745a033615714e72f27dbc06ed54aeddfb115028c30019ce76a4f45b424bbb39'
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
}
Get-ChocolateyWebFile @packageArgs

mkdir $pp.InstallDir -ea 0 | Out-Null
cp $tmp_path, $toolsPath\register_example.ps1 $pp.InstallDir -force

$runner_path = Join-Path $pp.InstallDir 'gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path

if ($pp.Service) {
    Write-Host "Installing gitlab-runner service"
    $cmd = "$runner_path install"
    if ($Username) {
        Add-User $Username $Password
        Add-ServiceLogonRight $Usersname
        $cmd += " --user $Env:COMPUTERNAME\$Username --password $Password" 
    }
    iex $cmd

    Write-Host "Starting service"
    iex "$runner_path start"
}