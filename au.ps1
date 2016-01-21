function Update() {

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
    "  $nuspecFile"
    "    updating version"
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

function Push() {
    if (Test-Path ../api_key) { $api_key = gc ../api_key } else { "File ./api_key not found, aborting push"; return }
    $package = (gi *.nupkg).Name
    cpush $package --api-key $api_key
}
