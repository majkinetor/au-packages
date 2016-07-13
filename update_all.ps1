param($Name = $null)
cd $PSScriptRoot

if (Test-Path update_vars.ps1) { . ./update_vars.ps1 }

$options = @{
    Timeout = 100
    Push    = $true
    Threads = 10

    Mail = if ($Env:mail_user) { @{
            To        = $Env:mail_user
            Server    = 'smtp.gmail.com'
            UserName  = $Env:mail_user
            Password  = $Env:mail_pass
            Port      = 587
            EnableSsl = $true
          }
        } else {}

    Gist_ID = $Env:Gist_ID
    Script = { param($Phase, $Info)
        if ($Phase -ne 'END') { return }

        save-runinfo
        save-gist
        git
    }
}

function save-runinfo {
    "Saving run info"
    $Info | Export-CliXML $PSScriptRoot\update_info.xml
}

function save-gist {
    function Expand-PoshString() {
        [CmdletBinding()]
        param ( [parameter(ValueFromPipeline = $true)] [string] $str)
        "@`"`n$str`n`"@" | iex
    }

    function ConvertTo-MarkdownTable($result, $Columns, $MaxErrorLength=150)
    {
        if (!$Columns) { $Columns = 'PackageName', 'Updated', 'Pushed', 'RemoteVersion', 'NuspecVersion', 'Error' }
        $res = '|' + ($Columns -join '|') + "|`r`n"
        $res += ((1..$Columns.Length | % { '|---' }) -join '') + "|`r`n"

        $result | % {
            $o = $_ | select @{N='PackageName'; E={'[{0}](https://chocolatey.org/packages/{0}/{1})' -f $_.PackageName, (max_version $_)} },
                    'Updated', 'Pushed', 'RemoteVersion', 'NuspecVersion',
                    @{N='Error'; E={
                        $err = ("$($_.Error)" -replace "`r?`n", '; ').Trim()
                        if ($err) {
                            if ($err.Length -gt $MaxErrorLength) { $err = $err.Substring(0,$MaxErrorLength) + ' ...' }
                            "[{0}](#{1})" -f $err, $_.PackageName.ToLower()
                        }
                    }}

            $res += ((1..$Columns.Length | % { $col = $Columns[$_-1]; '|' + $o.$col }) -join '') + "|`r`n"
        }

        $res
    }

    function max_version($p) {
        try {
            $n = [version]$p.NuspecVersion
            $r = [version]$p.RemoteVersion
            if ($n -gt $r) { "$n" } else { "$r" }
        } catch {}
    }

    function md_code($Text) {
        "`n" + '```'
        ($Text -join "`n").Trim()
        '```' + "`n"
    }

    "Saving results to gist"
    if (!(gcm gist.bat -ea 0)) { "ERROR: No gist.bat found: gem install gist"; return }

    $log = gc $PSScriptRoot\gist.md.ps1 -Raw | Expand-PoshString
    #$log | Out-File $PSScriptRoot\gist.md
    $log | gist.bat --filename 'Update-AUPackages.md' --update $Info.Options.Gist_ID
    if ($LastExitCode) { "ERROR: Gist update failed with exit code: '$LastExitCode'" }
}

function git() {
    $pushed = $Info.result.pushed
    if (!($pushed -and $pushed.Count)) { "Git: no package is pushed to chocolatey, skipping"; return }

    pushd $PSScriptRoot

    "`nExecuting git pull"
    git checkout master
    git pull

    "Commiting updated packages to git repository"
    $pushed | % { git add $_.PackageName }
    git commit -m "UPDATE BOT: $($pushed.length) packages updated"

    "`nPushing git changes"
    git push "https://$Env:github_user:$Env:github_pass@github.com/majkinetor/chocolatey.git"
    popd
}

updateall -Name $Name -Options $options | ft
$global:updateall = Import-CliXML $PSScriptRoot\update_info.xml

#Uncomment to fail the build on AppVeyor on any package error
#if ($updateall.error_count.total) { throw 'Errors during update' }
