import-module au

$releases = 'http://mpesch3.de1.cc/index.html'
$download = "http://www.winsoftware.de/Startedownload39417"

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate {    
    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    $archivePath = "$PSScriptRoot\mp3DC.exe"

    iwr $Latest.URL32 -OutFile $archivePath
    $Latest.Checksum32 = Get-FileHash $archivePath | % Hash

    rm $PSScriptRoot\tools -Recurse -Force -ea 0
    mkdir $PSScriptRoot\tools | Out-Null
    7z x $archivePath -otools
    rm $archivePath -ea ignore
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re  = 'Version ([.\d]+)'
    if ($download_page.Content -match $re) {  $version = $Matches[1] } else { throw "Can't find version by parsing the page" }

    @{
        Version = $version
        URL32   = $download
    }
}

update -ChecksumFor none
