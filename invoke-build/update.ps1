import-module au

$moduleName = 'InvokeBuild'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*[$]moduleName\s*=\s*)('.*')"= "`$1'$moduleName'"
        }
        ".\tools\chocolateyUninstall.ps1" = @{
            "(?i)(^\s*[$]moduleName\s*=\s*)('.*')"= "`$1'$moduleName'"
        }
   }
}

function global:au_BeforeUpdate {
    rm tools\$moduleName -Force -Recurse -ea 0
    Install-PackageProvider Nuget -Force
    Save-Module -Name $moduleName -Path tools
    'Invoke-Build.ArgumentCompleters', 'Invoke-TaskFromISE', 'Invoke-TaskFromVSCode','New-VSCodeTask' | % { Save-Script $_ -Path tools }
}

function global:au_GetLatest {
    $releases = "https://www.powershellgallery.com/packages/$moduleName"
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '/Download$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
    @{
        Version  = $url -split '/' | select -Last 1 -Skip 1
    }
}

update -NoCheckUrl -ChecksumFor none