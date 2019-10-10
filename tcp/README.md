This folder contains Total Commander plugin packages.

Majority of plugins are obtained from the following sources:

- https://www.ghisler.com/plugins.htm
- https://ghisler.ch/wiki/index.php/List_of_64-bit_plugins_and_addons
- http://www.totalcmd.net
- http://wincmd.ru/


All plugins are manual.

## [TCPS](tcps)

All plugin packages depend on `tcps` dependency with version `>=` to specific one. 

When it is updated:

- Search and replace all packages and set new version
- To force all packages to use new version without pushing new package version that has particular `tcps` version as dependency, **unlist** the older tcps version from the Gallery and publish new one. Then all packages will use it in the future as older tcps version doesn't exist any more.

## TCP and DCP

Those are virtual packages that install Total Commander and Double Commander respecivelly along with selection of plugins.
