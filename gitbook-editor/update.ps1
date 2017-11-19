import-module au

$releases = 'https://www.gitbook.com/editor/releases/all'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { 
    Write-Host "Downloading GitBook.Editor.Setup.exe from" $Latest.URL32
    rm tools\*.exe
    iwr -UseBasicParsing $Latest.URL32 -OutFile tools\GitBook.Editor.Setup.exe
    $Latest.Checksum32 = Get-FileHash tools\GitBook.Editor.Setup.exe | % Hash
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url =  $download_page.links.href | ? { $_ -like '*/version/*' } | select -First 1
    $version  = $url -split '/' | select -Last 1

    @{ Version  = $version; URL32 = $url; FileType = 'exe' }
}

update -ChecksumFor none -NoCheckUrl
