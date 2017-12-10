param([string]$IncludeStream, [switch]$Force)

import-module au

$releases = 'https://archive.apache.org/dist/lucene/solr'
$guides   = 'https://archive.apache.org/dist/lucene/solr/ref-guide'

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $versions = $download_page.links.href | ? {$_ -match '\d.\d' } | % { Get-Version $_ }
    $versions | sort | % { $vs =[ordered]@{}} { $vs[ $_.ToString(1) ] = $_ }
    $streams = [ordered]@{}
    foreach ($s in $vs.GetEnumerator()) {
        if ($s.Key -lt 4) { continue }
        $version = $s.Value
        $streams[$s.Key] = @{
            Version      = $version
            URL32        = "$releases/{0}/solr-{0}.zip" -f $version
            ReleaseNotes = "$releases/{0}/changes/Changes.html" -f $version
        }
    }
    
    @{ Streams = $streams }
}

update -ChecksumFor none -IncludeStream $IncludeStream -Force:$Force
