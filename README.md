[![](https://ci.appveyor.com/api/projects/status/github/majkinetor/chocolatey?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[![](http://transparent-favicon.info/favicon.ico)](#)[![](http://transparent-favicon.info/favicon.ico)](#)
[Update status](https://gist.github.com/majkinetor/a700c70b8847b29ebb1c918d47ee4eb1)
[![](http://transparent-favicon.info/favicon.ico)](#)
[chocolatey/majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 4+.
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package use `./New-Package.ps1 <Name>` function (change Github username inside this script). This script uses the template in the `_template` directory.

## Testing the package

In package directory run: `Test-Package`.

## Automatic package update

Run `<package_dir>/update.ps1` from within the directory of the package to update that package. If this script is missing, the package is not automatic.

Run `./update_all.ps1` from the repository root. Edit this script to change the [AU](https://github.com/majkinetor/au) update options.

You can also call AU method `Update-AUPackages` (alias `updateall`) in the repository root. This will avoid saving results to gist, sending mails on errors etc. and will just run update process for each package (temporary disable with `$au_NoPlugins`).

#### All Environment variables

If you want to use AU plugins to save results to Gist and/or Github git repository, you will have to setup the Github personal access token.

If the script `update_vars.ps1` exists besides `update_all.ps1`, it will be sourced so you can put environment variables there. If you are using the build server such as AppVeyor, define sensitive variables as secrets.

## How to use with your own packages

To use this system with your own AU packages do the following steps:

* Fork this project and clone it locally.
* Delete all existing packages:  
In the root of the repository run: `ls | ? PSISContainer | ?  Name -notlike '_*' | rm -Recurse`.
* Set your environment variables:
  * If you want to use AppVeyor edit the `appveyor.yml` environment section. The minimum for the system to work is to specify `$Env:api_key` in order to push updated packages to Chocolatey repository.
  * If you want to use on your own machine create `update_vars.ps1` and set the variables there.
* Add your own packages.  
You can use `./New-Package.ps1 <package_name>` to create one from the template. Just edit this script before using it first time to set up your GitHub chocolatey repository.

## Notes

- If you use Google mail for error notifications on a build server such as AppVeyor, Google will by default block authentication from unknown device. To receive those emails enable less secure apps - see [Allowing less secure apps to access your account](https://support.google.com/accounts/answer/6010255?hl=en). In any case, do not use your private email for this but create a new Google account and redirect its messages to your private one. This wont affect you if you run the scripts from your own machine from which you usually access the email.
- If you are using AppVeyor you should schedule your build under the _General_ options using [ncron](http://www.nncron.ru/help/EN/working/cron-format.htm) syntax, for example `0 22 * * *` runs the updater every night at 22h.
