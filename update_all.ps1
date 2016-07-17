param($Name = $null)
cd $PSScriptRoot

ls _user\*.ps1 | % { . $_ }
if (Test-Path update_vars.ps1) { . ./update_vars.ps1 }

$options = @{
    Timeout = 100
    Push    = $true
    Threads = 10

    Mail = if ($Env:mail_user) {
            @{
                To        = $Env:mail_user
                Server    = 'smtp.gmail.com'
                UserName  = $Env:mail_user
                Password  = $Env:mail_pass
                Port      = 587
                EnableSsl = $true
            }
           } else {}

    Gist_ID = $Env:Gist_ID

    Script = {
        param($Phase, $Info)

        if ($Phase -ne 'END') { return }

        Save-RunInfo
        Save-Gist
        Save-Git
    }
}

updateall -Name $Name -Options $options | ft
$global:updateall = Import-CliXML $PSScriptRoot\update_info.xml

#Uncomment to fail the build on AppVeyor on any package error
#if ($updateall.error_count.total) { throw 'Errors during update' }
