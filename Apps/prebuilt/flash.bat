:: Flash script

@echo off
setlocal enabledelayedexpansion

set COM_PORT=8
if not "x%1"=="x" set COM_PORT=%1

set UF_BAT=..\..\uf.bat

%UF_BAT% -config "%~dp0program.usf" -setOptions com=%COM_PORT% secure=false spPath="%~dp0servicepack_1.0.0.10.0.bin" -operations format servicePackUpdate program

