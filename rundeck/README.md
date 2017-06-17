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

* `/InstallDir` - Rundeck installation directory, by default `c:\rundeck`.
* `/Service` - Install rundeck Windows service. If value `0` is specified, service will be created but not started.
* `/CliOpts` - Value for `RDECK_CLI_OPTS`, by default `-Xms1048m -Xmx2096m`.
* `/SslOpts` - Value for `RDECK_SSL_OPTS`.
* `/AdminPwd` - Admin password, by default `admin`.
* `/DateFormat` - Date format.
* `/TokenDuration` - API token duration. Format: `##{ydhms}` (years, days, hours, minutes, seconds).
* `/EnableSsl` - Use self signed SSL as described in [SSL configuration](http://rundeck.org/docs/administration/configuring-ssl.html).

For example:

```
cinst rundeck --params "/InstallDir:c:\rundeck2 /AdminPwd:test123 /CliOpts:'-Xms2048m -Xmx4096m' /TokenDuration:10y /DateFormat:'yy-MM-dd HH:mm' /Service"
```

## Notes

* The package performs installation that is described in official [documentation](http://rundeck.org/docs/administration/installation.html#install-on-windows). After installation, you can access the service via URL http://localhost:4440.
