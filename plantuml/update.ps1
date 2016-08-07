import-module au

$releases = 'http://plantuml.com/changes.html'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.Content -match 'V\d{4,4}')
    {
        $version = "1." + $Matches[0].Substring(1)
        $url = "http://sourceforge.net/projects/plantuml/files/plantuml." + $version.Substring(2) + '.jar/download'
    }
    else { throw "Can't match version 'V\d{4,4}'" }

    return @{ URL = $url; Version = $version }
}

update -ChecksumFor 64
