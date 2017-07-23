function Get-RunnerInstallDir() {
    $res = Get-WmiObject win32_service | ? {$_.Name -eq 'gitlab-runner'} | select -Expand PathName
    if (!$res) { 
        if (!(gcm gitlab-runner.exe -ea 0)) { return }
        $res = (gitlab-runner.exe --shimgen-help 2>&1) -match '^\s*Target:' -replace "Target:|'"
        $res = $res.Trim()
    }
    $res = $res -split '\\gitlab-runner.exe' | select -First 1
    if (Test-Path $res) { return $res }
}

function Add-ServiceLogonRight([string] $Username) {
    Write-Host "Enable ServiceLogonRight for $Username"
    
    $tmp = New-TemporaryFile
    secedit /export /cfg "$tmp.inf" | Out-Null
    (gc -Encoding ascii "$tmp.inf") -replace '^SeServiceLogonRight .+', "`$0,$Username" | sc -Encoding ascii "$tmp.inf"
    secedit /import /cfg "$tmp.inf" /db "$tmp.sdb" | Out-Null
    secedit /configure /db "$tmp.sdb" /cfg "$tmp.inf" | Out-Null
    rm $tmp* -ea 0
}

function Add-User([string] $Username, [string] $Password ) {
    $user = Get-WmiObject win32_useraccount -Filter { LocalAccount = 'true' } | ? { $_.Name -eq $Username }
    if ($user) { Write-Host "User $Username already exists"; return } 

    Write-Host "Creating user $Username as local administrator"
    net user $Username $Password /add | Out-Null
    net localgroup Administrators $Username /add | Out-NUll
    $user = Get-WmiObject win32_useraccount -Filter { LocalAccount = 'true' } | ? { $_.Name -eq $Username }
    $user.PasswordExpires = $false
}