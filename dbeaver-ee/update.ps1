import-module au

$releases = 'https://dbeaver.com/files/dbeaver-ee-latest-x86_64-setup.exe'

function global:au_SearchReplace {
   @{
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(\s+x64:).*"      = "`${1} $($Latest.URL64)"
        "(?i)(checksum64:).*"  = "`${1} $($Latest.Checksum64)"
      }
   }
}


function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $request = [System.Net.WebRequest]::Create($releases)
    $request.AllowAutoRedirect=$false
    $response=$request.GetResponse()
    $url64 = $response.GetResponseHeader('Location')

    $version = $url64 -split '-' | select -Last 1 -Skip 2
    @{
        Version = $version
        URL64 = $url64
    }
}

update -ChecksumFor none
