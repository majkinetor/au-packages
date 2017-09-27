$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters

$current_dir = Get-RunnerInstallDir
if ($current_dir) {
    Write-Host 'Using previous gitlab-runner install path:' $current_dir
    $pp.InstallDir = $current_dir
} else {
    if (!$pp.InstallDir) { $pp.InstallDir = "c:\gitlab-runner" }
    Write-Host 'Using install directory:' $pp.InstallDir
}
$installDir = $pp.InstallDir

$is64 = (Get-ProcessorBits 64) -and $env:chocolateyForceX86 -ne 'true'
$runner_embedded = if ($is64) { Write-Host "Installing x64 bit version"; gi $toolsPath\*_x64.exe } else { Write-Host "Installing x32 bit version"; gi $toolsPath\*_x32.exe }

mkdir $installDir -ea 0 | Out-Null
mv $runner_embedded, $toolsPath\register_example.ps1 $installDir -force
ls $toolsPath\*.exe | % { rm $_ -ea 0; if (Test-Path $_) { touch "$_.ignore" }}
mv $installDir\gitlab*.exe $installDir\gitlab-runner.exe

$runner_path = Join-Path $installDir 'gitlab-runner.exe'
Install-BinFile gitlab-runner $runner_path

if ($pp.Service) {
    if ($pp.Autologon) { throw 'Autologon and Service parameters are mutally exclusive' }

    if ($pp.Service -is [string]) { 
        $Username, $Password = $pp.Service -split ':'
        if (!$Password) { throw 'When specifying service user, password is required' } 
    }

    Write-Host "Installing gitlab-runner service"
    $cmd = "$runner_path install"
    if ($Username) {
        Add-User $Username $Password
        Add-ServiceLogonRight $Username
        $cmd += " --user $Env:COMPUTERNAME\$Username --password $Password" 
    }
    iex $cmd

    Write-Host "Starting service"
    iex "$runner_path start"
}

if ($pp.Autologon) { 
    if ($pp.Service) { throw 'Autologon and Service parameters are mutally exclusive' }
    
    $Username, $Password = $pp.Autologon -split ':'
    Write-Host "Setting autologon for $Username"
    Set-AutoLogon $Username $Password  
}