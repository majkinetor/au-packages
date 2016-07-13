param($Name = $null)
cd $PSScriptRoot

if (Test-Path update_vars.ps1) { . ./update_vars.ps1 }

$options = @{
    Timeout = 100
    Push    = $true
    Threads = 10

    Mail = @{
        To       = $Env:mail_user
        Server   = 'smtp.gmail.com'
        UserName = $Env:mail_user
        Password = $Env:mail_pass
        Port     = 587
        EnableSsl= $true
    }

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
    $Info | Export-CliXML $PSScriptRoot\update_results.xml
}

function save-gist {
    function Expand-PoshString() {
        [CmdletBinding()]
        param ( [parameter(ValueFromPipeline = $true)] [string] $str)
        "@`"`n$str`n`"@" | iex
    }

    "Commiting pushed package to gist"
    if (!(gcm gist.bat -ea 0)) { "ERROR: No gist.bat found: gem install gist"; return }

    $log = gc $PSScriptRoot\gist.md.ps1 -Raw | Expand-PoshString
    $log | gist.bat --filename 'Update-AUPackages.md' --update $Info.Options.Gist_ID
    if ($LastExitCode) { "ERROR: Gist update failed with exit code: '$LastExitCode'" }
}

function git() {
    $pushed = $Info.results | ? Pushed
    if (!$pushed) { "Git: no updates, skipping"; return }

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
$global:updateall = Import-CliXML $PSScriptRoot\update_results.xml

#Uncomment to fail the build on AppVeyor on any package error
#if ($updateall.error_count.total) { throw 'Errors during update' }
