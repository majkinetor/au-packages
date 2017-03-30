function Get-RunnerInstallDir() {
    $res = Get-WmiObject win32_service | ? {$_.Name -eq 'gitlab-runner'} | select -Expand PathName
    if (!$res) { return }
    $res = $res -split '\\gitlab-runner.exe' | select -First 1
    if (Test-Path $res) { return $res }
}


