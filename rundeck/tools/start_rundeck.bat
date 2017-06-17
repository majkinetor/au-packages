set CURDIR=%~dp0
call %CURDIR%etc\profile.bat

set RDECK_CLI_OPTS=-Xmx4096m -Xms1024m
::set RDECK_SSL_OPTS=
java %RDECK_CLI_OPTS% %RDECK_SSL_OPTS% -Dfile.encoding=UTF-8 -jar rundeck-launcher.jar --skipinstall -d