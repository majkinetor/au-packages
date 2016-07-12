[![](https://ci.appveyor.com/api/projects/status/d508f777c9aypuv3?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[Update status](https://gist.github.com/majkinetor/181b18886fdd363158064baf817fa2ff)

**My chocolatey packages**: [majkinetor](https://chocolatey.org/profiles/majkinetor)


## Prerequisites

- Powershell 3+.
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

## Testing

**Build the package**

In package directory run `cpack`.

**Test locally**

In package directory run: `Test-Package` or `tp`.


## Automatic update

### Update single package

Run `<package_dir>/update.ps1` from within the directory of the package to update that package.

### Update all packages

Run `./update_all.ps1` from the repository root. Edit this file to change update options. This current script has the following features:

- Push package to Chocolatey  
Uses `$Env:api_key`
- Save results to gist  
Uses `$env:github_user`, `$env:github_pass` and `$env:gist_id`
- Push changes to git  
Uses `$env:github_user` and `$env:github_pass`
- Send error notifications to email  
Uses `$env:mail_user` and `$env:mail_pass`

### All Environment variables

If the script `update_vars.ps1` exists besides `update_all.ps1`, it will be sourced so you can put environment variables there. If you are using the build server such as Appvayor, define password variables as secrets.

```
$Env:mail_user
$Env:mail_pass
$Env:github_user
$Env:github_pass
$Env:gist_id
$Env:api_key
```
