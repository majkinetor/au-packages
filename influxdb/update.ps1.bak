. $PSScriptRoot\..\influxdb1\update.ps1

function global:au_SearchReplace {
   @{
        "$($Latest.PackageName).nuspec" = @{
            "(\<dependency .+?`"$($Latest.PackageName)1`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
        }
    }
}

function global:au_BeforeUpdate { }

update -ChecksumFor none
