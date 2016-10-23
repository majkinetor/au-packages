[![](https://ci.appveyor.com/api/projects/status/github/majkinetor/au-packages?svg=true)](https://ci.appveyor.com/project/majkinetor/au-packages)
[![](http://transparent-favicon.info/favicon.ico)](#)[![](http://transparent-favicon.info/favicon.ico)](#)
[Update status](http://tiny.cc/v1u1ey)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/majkinetor](https://chocolatey.org/profiles/majkinetor)

This repository contains [chocolatey automatic packages](https://chocolatey.org/docs/automatic-packages).

## Prerequisites

- Powershell 4+.
- [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package see [Creating the package updater script](https://github.com/majkinetor/au#creating-the-package-updater-script).

## Testing the package

In a package directory run: `Test-Package`.

## Automatic package update

### Single package

Run  from within the directory of the package to update that package:
   
    cd <package_dir>
    ./update.ps1

If this script is missing, the package is not automatic.  
Set `$au_Force = $true` prior to script call to update the package even if no new version is found.

### Multiple packages

To update all packages run `./update_all.ps1`. It accepts few options:

```powershell
./update_all.ps1 -Name a*                         # Update all packages which name start with letter 'a'
./update_all.ps1 -ForcedPackages 'cpu-z copyq'    # Update all packages and force cpu-z and copyq
./update_all.ps1 -ForcedPackages 'copyq:1.2.3'    # Update all packages but force copyq with explicit version
./update_all.ps1 -Root 'c:\packages'              # Update all packages in the c:\packages folder
```

The following global variables influence the execution of `update_all.ps1` script if set prior to the call:

```powershell
$au_NoPlugins = $true        #Do not execute plugins
$au_Push      = $false       #Do not push to chocolatey
```

You can also call AU method `Update-AUPackages` (alias `updateall`) in the repository root. This will just update each package without any other action. For example to force update of all packages with a single command execute:

    updateall -Options ([ordered]@{ Force = $true })

## Start using AU with your own packages

To use this system with your own packages do the following steps:

* Fork this project and clone it locally. If needed, rename it to `au-packages`.
* Delete all existing packages.
* Edit the `README.md` header with your repository info.
* Set your environment variables. See [AU wiki](https://github.com/majkinetor/au/wiki#environment-variables) for details.

Add your own packages now, with this in mind:
* You can keep both manual and automatic packages together. To get only AU packages any time use `Get-AUPackages` function (alias `lsau` or `gau`)
* Keep all package additional files in the package directory (icons, screenshots etc.). This keeps everything related to one package in its own directory so it is easy to move it around or remove it.
