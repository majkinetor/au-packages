$pp = Get-PackageParameters
if ($pp.DefaultPager) { Install-ChocolateyEnvironmentVariable "PAGER" "less" -VariableType 'Machine' }