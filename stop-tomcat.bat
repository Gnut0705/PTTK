@echo off
setlocal

set "JAVA_HOME=H:\Software\Java\jdk-25.0.4.1"
set "JRE_HOME=H:\Software\Java\jdk-25.0.4.1"
set "CATALINA_HOME=H:\Software\apache-tomcat-11.0.26"
set "CATALINA_BASE=H:\Software\apache-tomcat-11.0.26"

echo Dang dung Tomcat...
call "%CATALINA_HOME%\bin\shutdown.bat"
echo Da gui lenh dung Tomcat.
pause
