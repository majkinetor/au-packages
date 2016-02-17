
function Update-Package {
    [CmdletBinding()]
    param(
        [switch]$AllowTextualUrl
    )

    function Load-NuspecFile() {
        $nu = New-Object xml
        $nu.psbase.PreserveWhitespace = $true
        $nu.Load($nuspecFile)
        $nu
    }

    function check_uri($uri) {
        try
        {
            $HttpWebRequest = [System.Net.HttpWebRequest]::Create($uri)
            $HttpWebResponse = $HttpWebRequest.GetResponse()
            if (!$AllowTextualUrl -and $HttpWebResponse.ContentType -eq 'text/html') { $res = $false; $err='Invalid content type: text/html' }
            $res = $true
        }
        catch {
            $res = $false
            $err = $_
        }

        if (!$res) { throw "Can't validate uri '$uri': $err" }
    }

    function check_version($Version) {
        $re = '^[\d.]+$'
        if ($Version -notmatch $re) { throw "Version doesn't match the pattern '$re': '$Version'" }
    }

    function check() { check_uri $Latest.uri; check_version $Latest.version }

    $packageName = Split-Path $PSScriptRoot
    $nuspecFile = gi $packageName.nuspec -ea ig
    if (!$nuspecFile) {throw 'No nuspec file' }
    $nu = Load-NuspecFile
    $global:nuspec_version = $nu.package.metadata.version

    Write-Verbose "Checking package updates"
    try {
        $global:Latest  = au_GetLatest
    } catch {
        throw "au_GetLatest failed\n $_"
    }
    $latest_version        = $Latest.version

    check

    Write-Verbose "nuspec version: $nuspec_version"
    Write-Verbose "remote version: $latest_version"

    if ($latest_version -eq $nuspec_version) {
        Write-Verbose 'No new version found'
        return $true
    } else { Write-Verbose 'New version is available, updating' }

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

function Get-AUPackages($name) {
    ls .\*\update.ps1 | % {
        $packageDir = gi (Split-Path $_)
        if ($packageDir.Name -like "_*") { return }
        if ($packageDir -like "*$name*") { $packageDir }
    }
}

function Update-AUPackages($name) {
    $cd = $pwd
    $err = 0
    $pkg = 0
    Get-AUPackages $name | % {
        "-"*40; $_.Name
        $pkg += 1

        cd $_
        try { .\update.ps1 } catch { $err+=1; Write-Error $_ }
    }
    cd $cd

    ""
    "="*40
    "Automatic packages: $pkg"
    "Total errors: $err"
}

function Test-Package() {
    cpack
    cinst (gi *.nupkg).Name --source $pwd --force
}

sal updateall   Update-AuPackages
sal update      Update-Package
sal pp          Push-Package
sal gup         Get-AuPackages
sal test        Test-Package
