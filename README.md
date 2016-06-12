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

In package directory run:

    cpack; choco install (gi *.nupkg).Name --source $pwd --force

Or

    import-module au
    Test-Package


Automatic update
----------------

Run `./update.ps1` from within the directory of the package.
Use the following to update all packages:

    import-module au
    updateall
