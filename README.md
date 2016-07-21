[![](https://ci.appveyor.com/api/projects/status/9ipva7kgjigug2rn?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[Update status](https://gist.github.com/majkinetor/181b18886fdd363158064baf817fa2ff)

**My chocolatey packages**: [majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 3+.
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package use `./New-Package.ps1 <Name>` function (change Github username inside this script). This script uses the template in the `_template` directory.

## Testing the package

In package directory run: `Test-Package`.

## Automatic update

### Update single package

Run `<package_dir>/update.ps1` from within the directory of the package to update that package. If this script is missing, the package is not automatic.


### Update all automatic packages

Run `./update_all.ps1` from the repository root. Edit this script to change the [AU](https://github.com/majkinetor/au) update options.

You can also call AU method `Update-AUPackages` (alias `updateall`) in the repository root. This will avoid saving results to gist, sending mails on errors etc. and will just run update process for each package.

If you want to use custom update features to save results to gist and/or github git repository on your local machine, you will have to setup credentials on your own (check out AppVeyor build that has this automated).

#### All Environment variables

If the script `update_vars.ps1` exists besides `update_all.ps1`, it will be sourced so you can put environment variables there. If you are using the build server such as AppVeyor, define password variables as secrets.

```
$Env:mail_user   = ''
$Env:mail_pass   = ''
$Env:gist_id     = ''
$Env:api_key     = ''
```

## AppVeyor build

AppVeyor build has the following options:

- Push updated packages to Chocolatey  
Uses `$env:api_key`.
- Save run results to gist  
Uses `$env:github_user`, `$env:github_pass` and `$env:gist_id`. If not set, gist will be anonymous.
- Commit pushed packages to the git repository  
Uses `$env:github_user` and `$env:github_pass`. If not set package state may not be saved; if you run updater on your own machine, the state is saved on your file system. However, if updater is run by a build server which always starts a new (with a fresh repository copy), the state can only be saved if you provide your git repository credentials. The updater will work correctly in any case since you can publish package only once on Chocolatey repository and subsequent pushes will not be tried since `update` function doesn't update the package if the latest version returned already exists in the chocolatey repository.
- Send error notifications to email  
Uses `$env:mail_user` and `$env:mail_pass`.
- Send build failure notifications to email  
Uses `$env:mail_user

## How to use with your own packages

To use this system with your own AU packages do the following steps:

* Fork this project
* Delete all existing packages. In root of the repository run: `ls | ? PSISContainer | ?  Name -notlike '_*' | rm -Recurse`
* Set your environment variables
  * If you want to use AppVeyor edit the `appveyor.yml`. The minimum for the system to work is to specify `$Env:api_key` in order to push updated packages to Chocolatey repository.
  * If you want to use on your own machine create `update_vars.ps1` and set the variables there. You may want to install `gist` gem: `cinst ruby; gem install gist`.
* Add your own packages and you are ready to go.

## Notes

- If you use google mail for error notifications on a build server such as AppVeyor, google will by default block authentication from unknown device. To receive those emails enable less secure apps - see [Allowing less secure apps to access your account](https://support.google.com/accounts/answer/6010255?hl=en). In any case, do not use your private email for this but create a new one and redirect its messages to your private one. This wont affect you if you run the scripts from your own machine from which you usually access the email.
- If you are using AppVeyor you should schedule your build under General options using [ncron](http://www.nncron.ru/help/EN/working/cron-format.htm) syntax, for example `0 22 * * *` runs the updater every night at 22h.
- For gist to work over proxy you need to set console proxy environment variable. See [Update-CLIProxy](https://github.com/majkinetor/posh/blob/master/MM_Network/Update-CLIProxy.ps1) function.
