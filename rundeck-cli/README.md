# <img src="https://cdn.jsdelivr.net/gh/majkinetor/chocolatey/rundeck-cli/icon.png" width="48" height="48"/> [rundeck-cli](https://chocolatey.org/packages/rundeck-cli)

This is the CLI tool for Rundeck.

- [Command list](https://rundeck.github.io/rundeck-cli/commands)
- [Configuration](https://rundeck.github.io/rundeck-cli/configuration)

## Notes

- The installer creates a shim named `rdcli` instead `rd` because the later is PowerShell alias for `Remove-Item`.
- Related package: [rundeck](https://chocolatey.org/packages/rundeck) 

## Environment variables

Use the following variables to configure rundeck-cli:
 
```powershell
$Env:RD_URL           = 'http://localhost:4440'     # Connection info

$Env:RD_USER          = 'admin'
$Env:RD_PASSWORD      = 'admin'
$Env:RD_TOKEN         = '...'                       # Credentials
                  
$Env:RD_AUTH_PROMPT   = $false                      # Prompted to enter a username/password or token if not defined
$Env:RD_INSECURE_SSL  = $false                      # To disable all SSL certificate checks, and hostname verifications
$Env:RD_DEBUG         = ''                          # 1 - basic http request debug; 2 -http headers; 3 - http body
$Env:RD_CONNECT_RETRY = $true                       # Retry in case of recoverable connection issue (e.g. failure to connect)
$Env:RD_HTTP_TIMEOUT  = 30                          # HTTP/connect timeout
$Env:RD_DATE_FORMAT   = "yyyy-MM-dd'T'HH:mm:ssXX"   # Date format
```
