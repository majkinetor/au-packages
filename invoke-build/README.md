# <img src="https://cdn.rawgit.com/majkinetor/chocolatey/master/invoke-build/icon.png" width="48" height="48"/> [invoke-build](https://chocolatey.org/packages/invoke-build)

Invoke-Build is a build and test automation tool which invokes tasks defined in PowerShell v2.0+ scripts. It is similar to psake but arguably easier to use and more powerful. It is complete, bug free, well covered by tests.

## Features

- Incremental tasks with effectively processed inputs and outputs.
- Persistent builds which can be resumed after interruptions.
- Parallel builds in separate workspaces with common stats.
- Batch invocation of tests composed as tasks.
- Ability to define new classes of tasks.

Invoke-Build can invoke the current task from a build script being composed in ISE and VSCode, see *Invoke-TaskFromISE.ps1* and *Invoke-TaskFromVSCode.ps1*.

Invoke-Build can be used as the task runner in VSCode with tasks maintained in a PowerShell build script instead of *tasks.json*, see *New-VSCodeTask.ps1*.

Invoke-Build v3.0.1 is cross-platform with PowerShell v6.0.0-alpha.

## Notes

- Its recommended to include the following in your PowerShell `$PROFILE`:
    ```
    sal ib Invoke-Build
    & "$env:ChocolateyInstall\lib\invoke-build\tools\Invoke-Build.ArgumentCompleters.ps1"
    ```
