import-module au
. $PSScriptRoot\..\_scripts\all.ps1

$GitHubRepositoryUrl = 'https://github.com/plantuml/plantuml'

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase plantuml -NoSuffix
    Write-Host 'Downloading manual'
    $pdfFile = "tools\$(Split-Path -Leaf $Latest.Manual)"
    iwr $Latest.Manual -OutFile $pdfFile
    if ((gi $pdfFile).Length / 1MB -lt 1) {throw "Size of PDF manual too low" }
}

function global:au_GetLatest {
    $url = Get-GitHubReleaseUrl $GitHubRepositoryUrl 'plantuml-[0-9.]+\.jar$' | select -Last 1
    $version = $url -split '-|.jar' | select -First 1 -Skip 1

    @{
        Version      = $version
        URL32        = $url
        FileType     = 'jar'
        Manual       = "http://pdf.plantuml.net/PlantUML_Language_Reference_Guide_en.pdf"
        ReleaseNotes = $releases
    }
}

update -NoCheckUrl -ChecksumFor none
