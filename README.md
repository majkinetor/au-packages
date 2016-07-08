My chocolatey packages: https://chocolatey.org/profiles/majkinetor

Last update status: https://gist.github.com/majkinetor/b9fc258ccc6baece63a64b3f8d26d92a

Prerequisites
-------------

- Powershell 3+
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
