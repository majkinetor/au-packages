function Update-Package() {

    function Load-NuspecFile() {
        $nu = New-Object xml
        $nu.psbase.PreserveWhitespace = $true
        $nu.Load($nuspecFile)
        $nu
    }

    $nuspecFile = gi *.nuspec
    if (!$nuspecFile) {throw 'No nuspec file' }
    if ($nuspecFile -is [array]) { throw 'There is more then one .nuspec file' }
    $nu = Load-NuspecFile

    "Checking package updates.`n"
    $nuspec_version  = $nu.package.metadata.version
    $global:Latest   = au_GetLatest
    $latest_version  = $Latest.version

    'Versions:'
    "  nuspec: $nuspec_version"
    "  remote: $latest_version"
    ''

    if (!$latest_version) { throw "Invalid latest version: '$latest_version'" }
    if ($latest_version -eq $nuspec_version) {
        return 'No new version found.'
    } else { 'New version is available, updating' }

    'Updating files: '
    "  $(Split-Path $nuspecFile -Leaf)"
    "    updating version:  $nuspec_version -> $latest_version"
    $nu.package.metadata.version = "$latest_version"
    $nu.Save($nuspecFile)

    $sr = au_SearchReplace
    $sr.Keys | % {
        $fileName = $_
        "  $fileName"

        $fileContent = gc $fileName
        $sr[ $fileName ].GetEnumerator() | % {
            '    {0} = {1} ' -f $_.name, $_.value
            $fileContent = $fileContent -replace $_.name, $_.value
        }

        $fileContent | Out-File -Encoding UTF8 $fileName
    }

    'Package updated'
}

function Push-Package() {
    $ak = gi api_key -ea 0
    if (!$ak) { $ak = gi ../api_key -ea 0}
    if (!$ak) { throw "File api_key not found in this or parent directory, aborting push" }

    $api_key = gc $ak
    $package = (gi *.nupkg).Name
    cpush $package --api-key $api_key
}

function Show-AUPackages($name) {
    ls .\*\update.ps1 | % {
        $packageDir = gi (Split-Path $_)
        if ($packageDir.Name -like "_*") { return }
        if ($packageDir -like "*$name*") { $packageDir }
    }
}

function Update-AllPackages($name) {
    Show-AUPackages $name | % { "-"*40; $_.Name ; pushd $_; .\update.ps1; popd }
}

sal update Update-Package
sal push Push-Package
sal aup Show-AuPackages
