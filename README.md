My chocolatey packages:
https://chocolatey.org/profiles/majkinetor


**Prerequisites**

`cinst nuget.commandline`

**Build**

In package directory run `cpack`.

**Test**

If package is not installed:

    choco install (gi *.nupkg).Name -source $pwd

If already installed

    choco upgrade (gi *.nupkg).Name) -source $pwd

**Automatic package update**

Instead of using [official method](https://github.com/chocolatey/choco/wiki/AutomaticPackages) this repository uses custom auto updater that works as follows:

- Create script `update.ps1` in the root of the package.
- Import the update script: `. au.ps1`.
- Implement `au_GetLatest` function that returns HashTable with the latest remote version along with other arbitrary user data. The returned version is then compared to the one in nuspec file and if they do not differ update will stop.
- Implement `au_SearchReplace` function that returns HashTable containing search and replace data for any file.
- Call `update` to update at the end of the script to update the package.


See the [example](https://github.com/majkinetor/chocolatey/blob/master/dngrep/update.ps1) for details.
