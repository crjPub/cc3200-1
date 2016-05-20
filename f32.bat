:: Flash script
:: !!!CAN BE USED IN CYGWIN ONLY!!!

@echo off
setlocal enabledelayedexpansion

:: COM
set COM_PORT=8
if "x%1"=="x" (
        echo Please set COM port #!
        call :PrintHelp
        goto EXIT
        )
set COM_PORT=%1

if "x%2"=="x" (
        echo Please set the relative path to app in unix format!
        call :PrintHelp
        goto EXIT
        )

:: Config
set CONF_FILE=
for /f %%i in ('cygpath -w %2') do set CONF_FILE=%%i
if not exist %CONF_FILE% (
        echo "Config file not exist!"
        goto EXIT
        )

set CONF_PATH=%~dp0%CONF_FILE%

:: Options
set OPTIONS=
if "%3"==""     set OPTIONS=format servicePackUpdate program
if "%3"=="F"    set OPTIONS=format
if "%3"=="S"    set OPTIONS=servicePackUpdate
if "%3"=="P"    set OPTIONS=program
if "%3"=="FS"   set OPTIONS=format servicePackUpdate
if "%3"=="FSP"  set OPTIONS=format servicePackUpdate program

set UF_BAT=uf.bat
set SP_BIN=%~dp0Apps\prebuilt\servicepack_1.0.0.10.0.bin

:: Program
set PROGRAM=%UF_BAT% -config "%CONF_PATH%" -setOptions com=%COM_PORT% secure=false spPath="%SP_BIN%" -operations %OPTIONS%
echo %PROGRAM%
call %PROGRAM%
echo %PROGRAM%

goto EXIT

:PrintHelp
setlocal
echo Usage:
echo f32.bat COM# [app] [option]
echo * COM#:
echo     - Number of COM port, (1~255)
echo * config:
echo     - App path, relative path in unix format, eg Apps/hello/program.usf
echo * option:
echo     - F - foramt
echo     - S - servicePackUpdate
echo     - P - program
echo     - FS
echo     - FSP (default)
echo Example:
echo f32.bat 8 Apps/hello/program.usf P
endlocal

:EXIT

