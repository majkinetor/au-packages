function Build-Url {
    [CmdletBinding()]
	param (
		$version
	)

	$baseUrl = [string]::Format('http://dbeaver.jkiss.org/files/{0}/', $version)

	return [PSCustomObject]@{
        Url64bit=[string]::Format('{1}dbeaver-ee-{0}-x86_64-setup.exe', $version, $baseUrl)
        Url32bit=[string]::Format('{1}dbeaver-ee-{0}-x86-setup.exe', $version, $baseUrl)
    }
}

function Install-DBeaver {
    $tempPackageName = 'dbeaver.exe'
    $version = $env:chocolateyPackageVersion
    $urls = Build-Url -version $version
    $installArgs = '/S'

    Install-ChocolateyPackage $tempPackageName 'exe' $installArgs $urls.Url32bit $urls.Url64bit
}

Install-DBeaver