# AU Packages Template: https://github.com/majkinetor/au-packages-template

param([string[]] $Name, [string] $ForcedPackages, [string] $Root = $PSScriptRoot)

if (Test-Path $PSScriptRoot/update_vars.ps1) { . $PSScriptRoot/update_vars.ps1 }

$Options = [ordered]@{
    WhatIf        = $au_WhatIf                              #Whatif all packages
    Force         = $false                                  #Force all packages
    Timeout       = 100                                     #Connection timeout in seconds
    UpdateTimeout = 1200                                    #Update timeout in seconds
    Threads       = 10                                      #Number of background jobs to use
    Push          = $Env:au_Push -eq 'true'                 #Push to chocolatey
    PushAll       = $true                                   #Allow to push multiple packages at once
    PluginPath    = ''                                      #Path to user plugins
    IgnoreOn      = @(                                      #Error message parts to set the package ignore status
      'Origin Time-out'
      'Could not create SSL/TLS secure channel'
      'Could not establish trust relationship'
      'The operation has timed out'
      'Internal Server Error'
      'Service Temporarily Unavailable'
      'the package version already exists on the repository'
      'already exists on a Simple OData Server'             # https://github.com/chocolatey/chocolatey.org/issues/613
      'Conflict'
      'OutOfMemoryException'
    )
    RepeatOn      = @(                                      #Error message parts on which to repeat package updater
      'Could not create SSL/TLS secure channel'             # https://github.com/chocolatey/chocolatey-coreteampackages/issues/718
      'Could not establish trust relationship'              # -||-
      'Unable to connect'
      'The remote name could not be resolved'
      'Choco pack failed with exit code 1'                  # https://github.com/chocolatey/chocolatey-coreteampackages/issues/721
      'The operation has timed out'
      'Internal Server Error'
      'An exception occurred during a WebClient request'
      'remote session failed with an unexpected state'
      'the package version already exists on the repository'
      'already exists on a Simple OData Server'             # https://github.com/chocolatey/chocolatey.org/issues/613
      'Conflict'
      'Job returned no object'
    )
    #RepeatSleep   = 10                                     #How much to sleep between repeats in seconds, by default 0
    #RepeatCount   = 5                                      #How many times to repeat on errors, by default 1

    Report = @{
        Type = 'markdown'                                   #Report type: markdown or text
        Path = "$PSScriptRoot\Update-AUPackages.md"         #Path where to save the report
        Params= @{                                          #Report parameters:
            Github_UserRepo = $Env:github_user_repo         #  Markdown: shows user info in upper right corner
            NoAppVeyor  = $false                            #  Markdown: do not show AppVeyor build shield
            UserMessage = "[Ignored](#ignored) | [History](#update-history) | [Force Test](https://gist.github.com/$Env:gist_id_test) | [Releases](https://github.com/$Env:github_user_repo/tags) | **TESTING AU NEXT VERSION**"       #  Markdown, Text: Custom user message to show
            NoIcons     = $false                            #  Markdown: don't show icon
            IconSize    = 32                                #  Markdown: icon size
            Title       = ''                                #  Markdown, Text: TItle of the report, by default 'Update-AUPackages'
        }
    }

    History = @{
        Lines = 120                                         #Number of lines to show
        Github_UserRepo = $Env:github_user_repo             #User repo to be link to commits
        Path = "$PSScriptRoot\Update-History.md"            #Path where to save history
    }

    Gist = @{
        Id     = $Env:gist_id                               #Your gist id; leave empty for new private or anonymous gist
        ApiKey = $Env:github_api_key                        #Your github api key - if empty anoymous gist is created
        Path   = "$PSScriptRoot\Update-AUPackages.md", "$PSScriptRoot\Update-History.md"       #List of files to add to the gist
    }

    Git = @{
        User     = ''                                       #Git username, leave empty if github api key is used
        Password = $Env:github_api_key                      #Password if username is not empty, otherwise api key
        # Branch   = 'updates'
    }

    GitReleases  = @{
        ApiToken    = $Env:github_api_key                   #Your github api key
        ReleaseType = 'package'                             #Either 1 release per date, or 1 release per package
    }

    RunInfo = @{
        Exclude = 'password', 'apikey', 'apitoken'          #Option keys which contain those words will be removed
        Path    = "$PSScriptRoot\update_info.xml"           #Path where to save the run info
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
                SendAlways  = $false                        #Send notifications every time
             }
           } else {}

    ForcedPackages = $ForcedPackages -split ' '
    BeforeEach = {
        param($PackageName, $Options )

        $pattern = "^${PackageName}(?:\\(?<stream>[^:]+))?(?:\:(?<version>.+))?$"
        $p = $Options.ForcedPackages | ? { $_ -match $pattern }
        if (!$p) { return }

        $global:au_Force         = $true
        $global:au_IncludeStream = $Matches['stream']
        $global:au_Version       = $Matches['version']
    }
}

# Add some output regarding the SecurityProtocols
Write-Host "Enabled SecurityProtocols: "
[Net.ServicePointManager]::SecurityProtocol
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

if ($ForcedPackages) { Write-Host "FORCED PACKAGES: $ForcedPackages" }
$global:au_Root = $Root                                    #Path to the AU packages
$global:info = updateall -Name $Name -Options $Options

#Uncomment to fail the build on AppVeyor on any package error
#if ($global:info.error_count.total) { throw 'Errors during update' }
