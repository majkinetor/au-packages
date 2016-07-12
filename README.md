[![](https://ci.appveyor.com/api/projects/status/d508f777c9aypuv3?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[Update status](https://gist.github.com/majkinetor/181b18886fdd363158064baf817fa2ff)

**My chocolatey packages**: [majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 3+.
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

## Create a package

To create a new package use `./New-Package.ps1 <Name>` function (change Github username inside this script). This script uses the template in the `_template` directory.

## Test the package

In package directory run: `Test-Package`.

## Automatic update

### Update single package

Run `<package_dir>/update.ps1` from within the directory of the package to update that package:


### Update all packages

Run `./update_all.ps1` from the repository root. Edit this script to change the [AU]((https://github.com/majkinetor/au) update options. Currently this script has the following features:

- Push package to Chocolatey  
Uses `$Env:api_key`
- Save results to gist  
Uses `$env:github_user`, `$env:github_pass` and `$env:gist_id`
- Commit pushed packages to git repository  
Uses `$env:github_user` and `$env:github_pass`
- Send error notifications to email  
Uses `$env:mail_user` and `$env:mail_pass`

#### All Environment variables

If the script `update_vars.ps1` exists besides `update_all.ps1`, it will be sourced so you can put environment variables there. If you are using the build server such as Appvayor, define password variables as secrets.

```
$Env:mail_user
$Env:mail_pass
$Env:github_user
$Env:github_pass
$Env:gist_id
$Env:api_key
```


## Notes

- If you use google mail for error notifications on a build server such as Appvayor, google will by default block authentication from unknown device. To receive those emails enable less secure apps [Allowing less secure apps to access your account](https://support.google.com/accounts/answer/6010255?hl=en). In any case, do not use your private email for this but create a new one and redirect its messages to your private one. This wont affect you if you run the scripts from your own machine from which you usually access the email.
- If you are using Appvayor you should schedule your build under General options using [ncron](http://www.nncron.ru/help/EN/working/cron-format.htm) syntax, for example `0 22 * * *` runs the updater every night at 22h.
