if ($Env:PAGER -eq 'less') {
    Uninstall-ChocolateyEnvironmentVariable "PAGER" -VariableType 'Machine'
}