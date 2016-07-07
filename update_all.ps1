param($Name = $null)
cd $PSScriptRoot

$options = @{
    Timeout = 100
    Push    = $true
    Threads = 10
    Mail = @{
        To       = 'miodrag.milic@gmail.com'
        Server   = 'smtp.gmail.com'
        UserName = 'miodrag.milic@gmail.com'
        Password = gc $PSScriptRoot\mail_pass
        Port     = 587
        EnableSsl= $true
    }

    Script = { param($Phase, $Arg)
        if ($Phase -ne 'END') { return }

        cd $PSScriptRoot

        "Executing git pull"
        git pull

        $pushed = $Info.results | ? Pushed
        if ($pushed) {
            $pushed | % { git add $_.PackageName }
            "Commiting updated packages to git repository"
            git commit -m "Update bot: $($pushed.length) packages updated"
            git push
        }
    }
}

updateall -Name $Name -Options $options | Export-CliXML update_results.xml
