set CURDIR=%~dp0
call %CURDIR%etc\profile.bat
java %RDECK_CLI_OPTS% %RDECK_SSL_OPTS% -jar rundeck-launcher.jar --skipinstall -d