import-module au

$releases = 'http://dbeaver.jkiss.org/files/dbeaver-ee-latest-x86-setup.exe'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
        }
    }
}

function global:au_GetLatest {
    $url = $releases
    while($true) {
        $request = [System.Net.WebRequest]::Create($url)
        $request.AllowAutoRedirect=$false
        $response=$request.GetResponse()
        $location = $response.GetResponseHeader('Location')
        if (!$location -or ($location -eq $url)) { break }
        $url = $location
    }

    $url32 = $url
    $url64 = $url -replace '-x86-', '-x86_64-'
    $version = $url -split '-' | select -Last 1 -Skip 2

    $Latest = @{ URL64 = $url64; URL32 = $url32; Version = $version }
    return $Latest
}

update
