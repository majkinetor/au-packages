function Get-RunnerInstallDir() {
    $res = Get-WmiObject win32_service | ? {$_.Name -eq 'gitlab-runner'} | select -Expand PathName
    if (!$res) { return }
    $res = $res -split '\\gitlab-runner.exe' | select -First 1
    if (Test-Path $res) { return $res }
}

function Add-ServiceLogonRight([string] $Username) {
    $tmp = New-TemporaryFile
    secedit /export /cfg "$tmp.inf" | Out-Null
    (gc -Encoding ascii "$tmp.inf") -replace '^SeServiceLogonRight .+', "`$0,$Username" | sc -Encoding ascii "$tmp.inf"
    secedit /import /cfg "$tmp.inf" /db "$tmp.sdb" | Out-Null
    secedit /configure /db "$tmp.sdb" /cfg "$tmp.inf" | Out-Null
    rm $tmp* -ea 0
}