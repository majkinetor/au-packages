[![](https://ci.appveyor.com/api/projects/status/github/majkinetor/chocolatey?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[![](http://transparent-favicon.info/favicon.ico)](#)[![](http://transparent-favicon.info/favicon.ico)](#)
[Update status](http://tiny.cc/v1u1ey)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 4+.
- [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package see [Creating the package updater script](https://github.com/majkinetor/au#creating-the-package-updater-script).

## Testing the package

In a package directory run: `Test-Package`.

## Automatic package update

Run `<package_dir>/update.ps1` from within the directory of the package to update that package. If this script is missing, the package is not automatic.

You can also call AU method `Update-AUPackages` (alias `updateall`) in the repository root. This will just update each package without any other action.

## Start using AU with your own packages

To use this system with your own packages do the following steps:

* Fork this project and clone it locally.
* Delete all existing packages:  
In the root of the repository run: `ls | ? PSISContainer | ?  Name -notlike '_*' | rm -Recurse`.
* Set your environment variables. See [AU wiki](https://github.com/majkinetor/au/wiki/AppVeyor) for details.

Add your own packages now, with this in mind:
* You can keep both manual and automatic packages together. To get only AU packages any time use `Get-AUPackages` function (alias `lsau` or `gau`)
* Keep all package additional files in the package directory (icons, screenshots etc.). This keeps everything related to one package in its own directory.

