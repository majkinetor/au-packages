call %CURDIR%etc\profile.bat

set CURDIR=%~dp0
set RDECK_CLI_OPTS=-Xmx4096m -Xms1024m
set TIMEZONE=
::set RDECK_SSL_OPTS=

java %RDECK_CLI_OPTS% %RDECK_SSL_OPTS% %TIMEZONE% -Dfile.encoding=UTF-8 -jar rundeck.war --skipinstall -d >> %CURDIR%\rundeck.log 2>&1