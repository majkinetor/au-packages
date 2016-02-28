import-module au

$url = 'http://www.sonatype.org/downloads/nexus-latest-bundle.zip'

function global:au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function global:au_GetLatest {
    while($true) {
        Write-Host "Trying $url"
        $request = [System.Net.WebRequest]::Create($url)
        $request.AllowAutoRedirect=$false
        $response=$request.GetResponse()
        $location = $response.GetResponseHeader('Location')
        if (!$location -or ($location -eq $url)) { break }
        $url = $location
    }

    $version = ($url -split '-|\.' | select -Last 4 -skip 2) -join '.'
    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update -NoCheckUrl
