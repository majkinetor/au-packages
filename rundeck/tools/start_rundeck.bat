set CURDIR=%~dp0
set RDECK_CLI_OPTS=-Xmx4096m -Xms1024m
::set RDECK_SSL_OPTS=

call %CURDIR%etc\profile.bat
java %RDECK_CLI_OPTS% %RDECK_SSL_OPTS% -Dfile.encoding=UTF-8 -jar rundeck.war --skipinstall -d >> %CURDIR%\rundeck.log 2>&1