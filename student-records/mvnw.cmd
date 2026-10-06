@echo off
setlocal EnableExtensions
set "MAVEN_VERSION=3.9.11"
set "MAVEN_DIR=%~dp0.mvn\apache-maven-%MAVEN_VERSION%"
set "MAVEN_HOME=%MAVEN_DIR%"

if exist "%MAVEN_HOME%\bin\mvn.cmd" goto RUN_MAVEN

where mvn >nul 2>nul
if %ERRORLEVEL% EQU 0 goto RUN_GLOBAL

echo Maven is not installed globally. Downloading Apache Maven %MAVEN_VERSION% for this project...
set "MAVEN_ZIP=%TEMP%\apache-maven-%MAVEN_VERSION%-bin.zip"
set "MAVEN_URL=https://repo.maven.apache.org/maven2/org/apache/maven/apache-maven/%MAVEN_VERSION%/apache-maven-%MAVEN_VERSION%-bin.zip"

powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-WebRequest -UseBasicParsing -Uri '%MAVEN_URL%' -OutFile '%MAVEN_ZIP%' } catch { Write-Error $_; exit 1 }"
if errorlevel 1 (
  echo Failed to download Maven. Install Maven globally and run: mvn spring-boot:run
  exit /b 1
)

if exist "%MAVEN_HOME%" rmdir /s /q "%MAVEN_HOME%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%MAVEN_ZIP%' -DestinationPath '%~dp0.mvn' -Force"
if errorlevel 1 (
  echo Failed to extract Maven.
  exit /b 1
)
del /q "%MAVEN_ZIP%" >nul 2>nul

goto RUN_MAVEN

:RUN_GLOBAL
call mvn %*
exit /b %ERRORLEVEL%

:RUN_MAVEN
call "%MAVEN_HOME%\bin\mvn.cmd" %*
exit /b %ERRORLEVEL%
