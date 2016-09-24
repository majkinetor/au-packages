[![](https://ci.appveyor.com/api/projects/status/github/majkinetor/chocolatey?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[![](http://transparent-favicon.info/favicon.ico)](#)[![](http://transparent-favicon.info/favicon.ico)](#)
[Update status](http://tiny.cc/v1u1ey)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 4+.
- [Chocolatey Automatic Package Updater Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package use `./New-Package.ps1 <Name>` function (change Github username inside this script). This script uses the template in the `_template` directory.

## Testing the package

In package directory run: `Test-Package`.

## Automatic package update

Run `<package_dir>/update.ps1` from within the directory of the package to update that package. If this script is missing, the package is not automatic.

Run `./update_all.ps1` from the repository root. Edit this script to change the [AU](https://github.com/majkinetor/au) update options.

You can also call AU method `Update-AUPackages` (alias `updateall`) in the repository root. This will avoid saving results to gist, sending mails on errors etc. and will just run update process for each package (temporary disable with `$au_NoPlugins`).

## How to use with your own packages

To use this system with your own AU packages do the following steps:

* Fork this project and clone it locally.
* Delete all existing packages:  
In the root of the repository run: `ls | ? PSISContainer | ?  Name -notlike '_*' | rm -Recurse`.
* Set your environment variables. See [AU wiki](https://github.com/majkinetor/au/wiki/AppVeyor) for details.
* Add your own packages.  
You can use `./New-Package.ps1 <package_name>` to create one from the template. Just edit this script before using it first time to set up your GitHub chocolatey repository.
