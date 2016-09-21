param($Name = $null)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$options = [ordered]@{
    Timeout = 100
    Push    = $false
    Threads = 10

    Report = @{
        Type = 'markdown'
        Path = "$PSScriptRoot\Update-AUPackages.md"
        Params = @{ Github_UserRepo = $Env:github_user_repo }
    }

    Gist = @{
        Id = $Env:gist_id
        ApiKey = $Env:github_api_key
        Path = "$PSScriptRoot\Update-AUPackages.md"
    }

    Git = @{
            User     = ''
            Password = $Env:github_api_key
    }

    RunInfo = @{
        Path = "$PSScriptRoot\update_info.xml"
    }

    Mail = if ($Env:mail_user) {
            @{
                To        = $Env:mail_user
                Server    = 'smtp.gmail.com'
                UserName  = $Env:mail_user
                Password  = $Env:mail_pass
                Port      = 587
                EnableSsl = $true
                Attachment = "$PSScriptRoot\update_info.xml"
            }
           } else {}

}

updateall -Name $Name -Options $options | ft
