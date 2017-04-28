import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$releases = 'http://plantuml.com/changes.html'

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase plantuml -NoSuffix}
function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    if ($download_page.Content -match 'V\d\.\d{4,4}\.\d+')
    {
        $version = $Matches[0].Substring(1)
        $url = "https://sourceforge.net/projects/plantuml/files/plantuml." + $version + '.jar/download'
    }
    else { throw "Can't match version 'V\d{4,4}'" }

    @{
        URL32    = $url
        Version  = $version
        FileType = 'jar'
    }
}

try {
    update -NoCheckUrl -ChecksumFor none
} catch {
    $ignore = 'Unable to connect to the remote server'
    if ($_ -match $ignored) { Write-Host $ignore; 'ignore' }  else { throw $_ }
}
