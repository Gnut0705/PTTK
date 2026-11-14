@echo off
setlocal

echo ========================================================
echo        LibMan0 - Build and Run with Tomcat
echo ========================================================

:: 1. Thiet lap bien moi truong Tomcat va Java
set "JAVA_HOME=H:\Software\Java\jdk-25.0.4.1"
set "JRE_HOME=H:\Software\Java\jdk-25.0.4.1"
set "CATALINA_HOME=H:\Software\apache-tomcat-11.0.26"
set "CATALINA_BASE=H:\Software\apache-tomcat-11.0.26"

set "ANT_CMD=H:\Software\Apache NetBeans\extide\ant\bin\ant.bat"
set "WAR_FILE=dist\LibMan0.war"

:: 2. Build WAR bang Ant
echo [1/3] Dang bien dich du an bang Ant...
call "%ANT_CMD%" dist
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Build that bai! Vui long kiem tra loi bien dich Java o tren.
    pause
    exit /b %ERRORLEVEL%
)

:: 3. Copy WAR vao thu muc webapps cua Tomcat
echo.
echo [2/3] Dang copy LibMan0.war vao Tomcat webapps...
copy /Y "%WAR_FILE%" "%CATALINA_HOME%\webapps\LibMan0.war"
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Khong the copy file WAR vao webapps! Kiem tra xem file co bi khoa khong.
    pause
    exit /b %ERRORLEVEL%
)

:: 4. Khoi dong Tomcat
echo.
echo [3/3] Dang khoi dong Apache Tomcat...
echo.
echo ========================================================
echo Cac duong dan truy cap ung dung:
echo   - Quan ly: http://localhost:8080/LibMan0/manager/gdManagerHome0.jsp
echo   - Ban doc: http://localhost:8080/LibMan0/reader/gdReaderHome0.jsp
echo.
echo [LUU Y] Nhan Ctrl + C de dung Tomcat khi khong su dung nua.
echo ========================================================
echo.

call "%CATALINA_HOME%\bin\catalina.bat" run

if %ERRORLEVEL% neq 0 (
    echo.
    echo Tomcat da dung hoac gap loi khi khoi dong.
    pause
)
