param([string]$ApiKey)

if ($ApiKey) { nuget SetApiKey $ApiKey -source https://chocolatey.org }
$package = (gi *.nupkg).Name
cpush $package

