[![](https://ci.appveyor.com/api/projects/status/d508f777c9aypuv3?svg=true)](https://ci.appveyor.com/project/majkinetor/chocolatey)
[Update status](https://gist.github.com/majkinetor/181b18886fdd363158064baf817fa2ff)

**My chocolatey packages**: [majkinetor](https://chocolatey.org/profiles/majkinetor)


Prerequisites
-------------

- Powershell 3+.
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

Testing
-------

**Build the package**

In package directory run `cpack`.

**Test locally**

In package directory run: `Test-Package` or `tp`.


Automatic update
----------------

**Update single package**

Run `<package_dir>/update.ps1` from within the directory of the package to update that package.

**Update all packages**

Run `./update_all.ps1`. Edit this file to change options.


Environment variables
---------------------

```
$Env:mail_user  
$Env:mail_pass  
$Env:github_user
$Env:github_pass
$Env:api_key    
$Env:gist_id    
```
