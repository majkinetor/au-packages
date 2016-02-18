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

In package directory run:

    cpack; choco install (gi *.nupkg).Name --source $pwd --force


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
            ...
            searchN = replaceN 
        }
        file_path2 = @{ ... }
    }
  ~~~

- Call the `update` function from the `au.ps1` script to update the package.

This is best understood via the [example](https://github.com/majkinetor/chocolatey/blob/master/dngrep/update.ps1).

With this set, you can Call individual `update.ps1` from within its directory to update that specific package.

Updating all packages
---------------------

You can update all packages and optionally push them to chocolatey repository with single command. 

Function `Update-AUPackages` will iterate over `update.ps1` scripts and execute each. If it detects that package is updated it will `cpack` it and push it. 
The function does some rudimentary verifications of URLs and version strings.
For push to work, specify your api key in the file `api_key` in the script's directory.

This function is designed for scheduling. You can use `Install-AUScheduledTask` to install daily task scheduler task that points to the `update_all.ps1` script. In this scenario, we want to be notified about possible errors during packages update procedure. If the update procedure fails for any reasons there is an option to send an email with results as an attachment in order to investigate the problem. This is the prototype of the `update_all.ps1`:

    cd $PSScriptRoot
    . .\au.ps1

    $options = @{
        Mail = @{
            To       = 'meh@gmail.com'
            Server   = 'smtp.gmail.com'
            UserName = 'meh@gmail.com'
            Password = '**************'
            Port     = 587
            EnableSsl= $true
        }
    }

    Update-AUPackage -Options $options | Export-CliXML update_results.xml

Specify function parameter `Name` to specify package names via glob, for instance "d*" would update only packages which names start with the letter 'd'. Add `Push` among options to push sucesifully built packages to the chocolatey repository. The result may look like this:

    PS C:\chocolatey> .\update_all.ps1

    Updating all automatic packages
    copyq is updated to 2.6.1 and pushed 
    dngrep had errors during update
        Can't validate URL 'https://github.com/dnGrep/dnGrep/releases/download/v2.8.16.0/dnGREP.2.8.16.x64.msi'
        Exception calling "GetResponse" with "0" argument(s): "The operation has timed out"
    eac has no updates
    pandoc has no updates
    plantuml has no updates
    yed had errors during update
        Can't validate URL 'https://www.yworks.com'
        Invalid content type: text/html

    Automatic packages processed: 6
    Total errors: 2
    Mail with errors sent to xyz@gmail.com

The attachment is `$result` object which can be loaded with `Import-CliXml` and inspected.
