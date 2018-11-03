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
    
    $scripts =  'Invoke-Build.ArgumentCompleters', 'Invoke-TaskFromISE', 'Invoke-TaskFromVSCode',
                'New-VSCodeTask', 'Show-BuildTree', 'Show-BuildDgml'
    
    $scripts | % { iwr https://raw.githubusercontent.com/nightroman/Invoke-Build/master/$_.ps1 -OutFile tools\$_.ps1 }
}

function global:au_GetLatest {
    $releases = "https://www.powershellgallery.com/packages/$moduleName"
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url = ($download_page.Content -split '\n' | sls 'DownloadNupkg_Button' ).ToString().Split("'") | select -Last 1 -Skip 1
    @{
        Version  = $url -split '/' | select -Last 1
    }
}

update -NoCheckUrl -ChecksumFor none
