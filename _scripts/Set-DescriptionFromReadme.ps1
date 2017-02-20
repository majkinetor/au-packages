function Set-DescriptionFromReadme([int]$SkipFirst=0, [int]$SkipLast=0) {
    if (!(Test-Path README.md)) { throw 'Set-DescriptionFromReadme: README.md not found' }

    Write-Host 'Setting README.md to Nuspec description tag'
    $description = gc README.md -Encoding UTF8
    $endIdx = $description.Length - $SkipLast
    $description = $description | select -Index ($SkipFirst..$endIdx) | Out-String

    $nuspecFileName = $Latest.PackageName + ".nuspec"
    $nu = gc $nuspecFileName -Raw
    $nu = $nu -replace "(?smi)(\<description\>).*?(\</description\>)", "`${1}$($description)`$2"

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding($False)
    $n = (Resolve-Path $NuspecFileName)
    [System.IO.File]::WriteAllText($n, $nu, $Utf8NoBomEncoding)
}

sal readme2desc Set-DescriptionFromReadme
