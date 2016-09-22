# AU template: https://raw.githubusercontent.com/majkinetor/au/master/update_all_default.ps1
#    env vars: https://raw.githubusercontent.com/majkinetor/au/master/update_vars_default.ps1

param($Name = $null)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$options = [ordered]@{
    Timeout = 100
    Push    = $Env:au_Push -eq 'true'
    Threads = 10

    Report = @{
        Type   = 'markdown'
        Path   = "$PSScriptRoot\Update-AUPackages.md"
        Params = @{
            Github_UserRepo = $Env:github_user_repo
            UserMessage     = "**TESTING AU integrate branch**"
        }
    }

    Gist = @{
        Id     = $Env:gist_id
        ApiKey = $Env:github_api_key
        Path   = "$PSScriptRoot\Update-AUPackages.md"
    }

    Git = @{
        User     = ''
        Password = $Env:github_api_key
        Force = $true
    }

    RunInfo = @{
        Path = "$PSScriptRoot\update_info.xml"
    }

    Mail = if ($Env:mail_user) {
            @{
                To         = $Env:mail_user
                Server     = 'smtp.gmail.com'
                UserName   = $Env:mail_user
                Password   = $Env:mail_pass
                Port       = 587
                EnableSsl  = $true
                Attachment = "$PSScriptRoot\update_info.xml"
            }
           } else {}
}
$au_Root = $PSScriptRoot
$info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($info.error_count.total) { throw 'Errors during update' }
