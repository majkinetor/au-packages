$ErrorActionPreference = 'Stop'
$packageParameters = $env:chocolateyPackageParameters

$port = 22
$password = 'root'

if ($packageParameters) {
    $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
    $option_name = 'option'
    $value_name = 'value'
    $arguments = @{}

    if ($packageParameters -match $match_pattern ){
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | % {
        $arguments.Add(
            $_.Groups[$option_name].Value.Trim(),
            $_.Groups[$value_name].Value.Trim())
    }
    }
    else
    {
        Throw "Package Parameters were found but were invalid (REGEX Failure)"
    }

    if ($arguments.ContainsKey("Port")) {
        Write-Host "Port Argument Found"
        $port = $arguments["Port"]
    }

    if ($arguments.ContainsKey("Password")) {
        Write-Host "Password Argument Found"
        $password = $arguments["Password"]
    }
}

$packageName = 'openssh'
$url         = 'http://www.mls-software.com/files/setupssh-7.1p2-1.exe'

$packageArgs = @{
  packageName            = $packageName
  fileType               = 'EXE'
  url                    = $url
  url64Bit               = $url
  #Start-Process "$temp\openssh.exe" "/S /port=22 /privsep=1 /password=$ssh_admin_pass" -NoNewWindow -Wait
  silentArgs             = "/S /port=$port /privsep=1 /password=$password"
  validExitCodes         = @(0)
  registryUninstallerKey = $packageName
}
Install-ChocolateyPackage @packageArgs

$local_key     = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key   = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
$machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
$key = Get-ItemProperty -Path @($machine_key6432, $machine_key, $local_key) -ErrorAction SilentlyContinue | ? { $_.DisplayName -like "$packageName*" }
if ($key) {
    $installLocation = Split-Path $key.UninstallString
    if (Test-Path $installLocation)  {
        Write-Host "$packageName installed to '$installLocation'"
    }
}
