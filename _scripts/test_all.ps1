# all | random [n]
param([string] $Name, [string] $Root = "$PSScriptRoot\..")

if (Test-Path $PSScriptRoot/../update_vars.ps1) { . $PSScriptRoot/../update_vars.ps1 }

$options = [ordered]@{
    Force = $true
    Push = $false

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Test-Report.md"               #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
            Title       = 'AU Pakcage Force Test'
        }
    }

    Gist = @{
        Id     = $Env:gist_id                               #Your gist id; leave empty for new private or anonymous gist
        ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
        Path   = "$PSScriptRoot\Test-Report.md"             #List of files to add to the gist
    }
}
$au_root = $Root
updateall -Name $Name -Options $Options
