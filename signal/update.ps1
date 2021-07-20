import-module au

$releases = 'https://github.com/WhisperSystems/Signal-Desktop/tags'
function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"       = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum32)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $download_page.links.href -match 'tag/v[0-9.]+$' | Select -First 1 | % { $_ -split '/' | select -Last 1 }
    $version = $version.Substring(1)
    @{
        Version      = $version
        URL32        = "https://updates.signal.org/desktop/signal-desktop-win-$version.exe"
        ReleaseNotes = "https://github.com/WhisperSystems/Signal-Desktop/releases/tag/v$version"
    }
}

try {
    update
} catch  {
    if ($_ -match '404') { Write-Host "$_"; return 'ignore' }
}
