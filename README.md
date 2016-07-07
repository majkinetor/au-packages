My chocolatey packages: https://chocolatey.org/profiles/majkinetor

Prerequisites
-------------

- Powershell 3+
- [Automatic Chocolatey Package Update Powershell Module](https://github.com/majkinetor/au): `Install-Module au`

Manual Testing
--------------

**Build**

In package directory run `cpack`.

**Test**

In package directory run: `Test-Package` or `tp`.


Automatic update
----------------

**Update single package**

Run `<package_dir>/update.ps1` from within the directory of the package to update that package.

**Update all packages**

Run `./update_all.ps1`. Edit this file to change options.
