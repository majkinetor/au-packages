My chocolatey packages: https://chocolatey.org/profiles/majkinetor

Prerequisites
-------------

- Powershell 3+
- `cinst nuget.commandline`

Manual Testing
--------------

**Build**

In package directory run `cpack`.

**Test**


    choco install (gi *.nupkg).Name --source $pwd --force


Automatic package update
------------------------

Instead of using [official method](https://github.com/chocolatey/choco/wiki/AutomaticPackages) this repository uses the custom auto updater developed in Powershell that works as follows:

- In the package directory, create the script `update.ps1`.
- Source the helper update script: `. au.ps1`.
- Implement two functions:
  - `au_GetLatest`   
  Function returns HashTable with the latest remote version along with other arbitrary user data which you can use elsewhere (for instance in search and replace). The returned version is then compared to the one in nuspec and if they are different, the files will be updated. This hashtable is available via global variable `$Latest`.
  - `au_SearchReplace`  
  Function returns HashTable containing search and replace data for any file in the form: 
  ~~~
    @{ 
        file_path1 = @{ 
            search1 = replace1
            searchN = replaceN 
        }
        file_path2 = @{
            search1 = replace1
        }
    }
  ~~~

- Call the `update` function from the `au.ps1` script to update the package.

This is best understood via the [example](https://github.com/majkinetor/chocolatey/blob/master/dngrep/update.ps1).

With this set, you can:

- Call individual `update.ps1` to update specific package.
- Update all packages using `update_all.ps1` - the script will call each `update.ps1` it finds and pack/push the package if there are changes. You can see its cummulative transcript in the `update_all.log`. For push to work, specify your api key in the file `api_key` in the scripts directory.
- Schedule `update_all.ps1` using `install_ts.ps1` to install scheduled task that runs daily. Edit this script to configure scheduled task. This script requires Windows8++ (you will have to manually create scheduled task on older systems).

