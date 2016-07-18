import-module au

$releases = 'https://www.yworks.com/products/yed/download'

function global:au_SearchReplace {
    @{".\tools\chocolateyInstall.ps1" = @{ "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL)'" }}
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    if ($download_page.RawContent -match 'resources/yed/demo/.+\.zip')
    {
        $url = "https://www.yworks.com/" + $Matches[0]
    }

    #$url = "https://www.yworks.com/resources/yed/demo/yEd-3.14.4.zip"
    $version  = $url -split '[_-]|.zip' | select -Last 1 -Skip 1

    $Latest = @{ URL = $url; Version = $version }
    return $Latest
}

update
