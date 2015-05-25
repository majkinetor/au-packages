My chocolatey packages:

https://chocolatey.org/profiles/majkinetor


**Prerequisites**

`cinst nuget.commandline`

**Build**

In package directory run `cpack`.

**Test**

`cinst [PackageName] -source $pwd

**Push**

In package directory run ``..\push.ps1 [API_KEY]`` Once specified `API_KEY` parameter can be omitted.
