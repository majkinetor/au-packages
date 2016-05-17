# MM-Choco.Extension


This is the Powershell module that extends Chocolatey with new functions. The intended use for module is to supplement package authors with new functions.


## Installation

Install via chocolatey: `cinst mm-choco.extension`. 


## Usage

To create a package that uses a extension function add the following to the `nuspec` specification:

    <dependencies>
        <dependency id="mm-choco.extension" version="0.0.1" />
    </dependencies>

Make sure you use adequate version.

To test the functions you can import the chocolatey module. For example:


    PS> import-module -force $Env:ChocolateyInstall\helpers\chocolateyInstaller.psm1
    PS> Get-AppInstallLocation choco -Verbose

    VERBOSE: Trying local and machine (x32 & x64) Uninstall keys
    VERBOSE: Trying Program Files with 2 levels depth
    VERBOSE: Trying PATH
    C:\ProgramData\chocolatey\bin
