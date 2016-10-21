# AU template: https://github.com/majkinetor/au-packages-template

param($Name = $null, [string] $ForcedPackages)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    Timeout = 100
    Push    = $Env:au_Push -eq 'true'
    Threads = 10

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options )
        if ($Options.ForcedPackages -contains $PackageName) { $global:au_Force = $true }
    }

    Report = @{
        Type   = 'markdown'
        Path   = "$PSScriptRoot\Update-AUPackages.md"
        Params = @{
            Github_UserRepo = $Env:github_user_repo
            UserMessage     = "**USING AU NEXT VERSION**"
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
    }

    RunInfo = @{
        Path = "$PSScriptRoot\update_info.xml"
    }

    Mail = if ($Env:mail_user) {
            @{
                To         = $Env:mail_user
                Server     = $Env:mail_server
                UserName   = $Env:mail_user
                Password   = $Env:mail_pass
                Port       = $Env:mail_port
                EnableSsl  = $Env:mail_enablessl -eq 'true'
                Attachment = "$PSScriptRoot\update_info.xml"
                UserMessage = "<p>Update status: http://tiny.cc/v1u1ey</p>"
            }
           } else {}
}

if ($ForcedPackages) { Write-Host "FORCED PACKAGES:  $ForcedPackages" }
$au_Root = $PSScriptRoot
$info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($info.error_count.total) { throw 'Errors during update' }
