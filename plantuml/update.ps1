. ../au.ps1

$releases = 'http://plantuml.com/changes.html'

function au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.Content -match 'V\d{4,4}')
    {
        $version = "1." + $Matches[0].Substring(1)
        $url = "http://netix.dl.sourceforge.net/project/plantuml/plantuml." + $version.Substring(2) + ".jar"
    }
    else { throw "Can't match version 'V\d{4,4}'" }

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
