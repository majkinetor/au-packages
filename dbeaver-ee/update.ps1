import-module au

$releases = 'https://dbeaver.com/files/dbeaver-ee-latest-x86-setup.exe'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
        }
   }
}



function global:au_GetLatest {
    $request = [System.Net.WebRequest]::Create($releases)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
    $url32 = $response.GetResponseHeader('Location')
    $url64 = $url32 -replace '-x86-', '-x86_64-'

    $version = $url32 -split '-' | select -Last 1 -Skip 2
    @{ URL64 = $url64; URL32 = $url32; Version = $version }
}


update -NoCheckUrl
