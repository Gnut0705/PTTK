@echo off
setlocal

set "JAVA_HOME=H:\Software\Java\jdk-25.0.4.1"
set "JRE_HOME=H:\Software\Java\jdk-25.0.4.1"
set "CATALINA_HOME=H:\Software\apache-tomcat-11.0.26"
set "CATALINA_BASE=H:\Software\apache-tomcat-11.0.26"

echo Dang khoi dong Tomcat trong mot cua so rieng...
call "%CATALINA_HOME%\bin\startup.bat"
echo Da khoi dong Tomcat! Ban co the mo trinh duyet truy cap:
echo http://localhost:8080/LibMan0/manager/gdManagerHome0.jsp
pause
