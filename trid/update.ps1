import-module au

$trid_url     = 'http://mark0.net/download/trid_w32.zip'
$triddefs_url = 'http://mark0.net/download/triddefs.zip'

function global:au_SearchReplace {
   @{

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+trid:).*"             = "`${1} $trid_url"
          "(?i)(\s+triddefs:).*"         = "`${1} $triddefs_url"
          "(?i)(checksum_trid:).*"       = "`${1} $($Latest.checksum_trid)"
          "(?i)(checksum_triddefs:).*"   = "`${1} $($Latest.checksum_triddefs)"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_BeforeUpdate { 
    Invoke-WebRequest -Uri $triddefs_url -OutFile tools\triddefs.zip
    $Latest.checksum_triddefs = Get-FileHash tools\triddefs.zip | % Hash
    7z e tools\triddefs.zip -otools -aoa
    rm tools\triddefs.zip
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {

    # trid.exe version
    Invoke-WebRequest -Uri $trid_url -OutFile tools\trid.zip
    7z e tools\trid.zip -otools -aoa
    $Latest.checksum_trid = Get-FileHash tools\trid.zip | % Hash
    rm tools\trid.zip

    $res = .\tools\trid.exe | Out-String
    $res -match 'File Identifier v(.+?)-' | Out-Null
    $version_trid = $Matches[1].Trim()

    # trid_defs version
    [xml]$rss = Invoke-WebRequest 'http://mark0.net/forum/index.php?action=.xml;sa=recent;board=8.0;limit=15;type=rss2' -UseBasicParsing
    $item1 = $rss.rss.channel.item | Select -First 1     #Sat, 15 Jul 2017 14:03:31 GMT
    $date = $item1.pubDate
    $version_def = [datetime]::Parse($date).ToString('yyyyMMdd')

    @{
        Version       = "${version_trid}.${version_def}"
        ReleaseNotes  = $item1.link
    }
}

sal 7z $env:ChocolateyInstall\tools\7z.exe
mkdir $PSScriptRoot\tools -ea 0
update -ChecksumFor none -NoCheckUrl
