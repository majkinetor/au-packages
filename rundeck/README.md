# <img src="https://cdn.rawgit.com/majkinetor/chocolatey/master/rundeck/icon.png" width="48" height="48"/> [rundeck](https://chocolatey.org/packages/rundeck)

Rundeck is open source software that helps you automate routine operational procedures in data center or cloud environments. Rundeck provides a number of features that will alleviate time-consuming grunt work and make it easy for you to scale up your automation efforts and create self service for others. Teams can collaborate to share how processes are automated while others are given trust to view operational activity or execute tasks.

Rundeck allows you to run tasks on any number of nodes from a web-based or command-line interface. Rundeck also includes other features that make it easy to scale up your automation efforts including: access control, workflow building, scheduling, logging, and integration with external sources for node and option data.

## Features

* Web API
* Distributed command execution
* Pluggable execution system (SSH by default)
* Multi-step workflows
* Job execution with on demand or scheduled runs
* Graphical web console for command and job execution
* Role-based access control policy with support for LDAP/ActiveDirectory
* History and auditing logs
* Open integration to external host inventory tools
* Command line interface tools

## Package parameters

- `/InstallDir` - Rundeck installation directory, by default `c:\rundeck`.
- `/Service` - Install rundeck Windows service.

## Notes

* The package performs installation that is described in official [documentation](http://rundeck.org/docs/administration/installation.html#install-on-windows). After installation, you can access the service via URL http://localhost:4440.