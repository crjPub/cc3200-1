:: Flash script
:: Support both Cygwin and Windows CMD

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

:: Config
set CONF_PATH=%~dp0program.usf

:: Options
set OPTIONS=
if "%3"==""     set OPTIONS=format servicePackUpdate program
if "%3"=="F"    set OPTIONS=format
if "%3"=="S"    set OPTIONS=servicePackUpdate
if "%3"=="P"    set OPTIONS=program
if "%3"=="FS"   set OPTIONS=format servicePackUpdate
if "%3"=="FSP"  set OPTIONS=format servicePackUpdate program

set UF_BAT=..\..\uf.bat
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
echo flash.bat COM# [option]
echo * COM#:
echo     - Number of COM port, (1~255)
echo * option:
echo     - F - foramt
echo     - S - servicePackUpdate
echo     - P - program
echo     - FS
echo     - FSP (default)
echo Example:
echo flash.bat 8
echo flash.bat 8 P
echo flash.bat 8 FSP
endlocal

:EXIT

