:: UniFlash CLI wrapper for CC3200 program

@echo off
setlocal enabledelayedexpansion

:: TI UniFlash programmer path
:: Set path to your own, (eg, D:\ProgramFiles\TI\UniFlash)
set UNIFLASH_PATH=C:\TI\uniflash_3.4

call "%UNIFLASH_PATH%\eclipse\command_line\cc3xx_cmd.bat" %*

:EXIT

:: Usage:
::	 uf.bat [CONFIG] [SETTINGS] [OPERATION]
:: 	 uf.bat -help
::
:: [CONFIG]:
::     -config <configPath>
::
:: [SETTINGS]
::     -listOptions
::     -setOptions <OptID1>=<Value1> ... <OptIDN>=<ValueN>
::
:: [OPERATION]
::     -listOperations
::     -operation <opCode1> ... <opCodeN>
::
:: <End of command>
::
::
:: The following table summarizes all command line arguments:
::
:: +-------------------+-----------+-----------------------------------------------+-----------------------------------------------------------------+
:: | Argument          | Required? | Default                                       | Description                                                     |
:: +-------------------+-----------+-----------------------------------------------+-----------------------------------------------------------------+
:: | config            | yes       | N/A                                           |
:: | listOptions       | no        | N/A                                           |
:: | listOperations    | no        | N/A                                           |
:: | com               | no        | Decimal number indicating the COM port        | Indicates the COM port to be used when connecting to the device
:: | imagePath         | no        | String indicating the path                    | Indicates the path to the image file
:: | imageVerify       | no        | false                                         | Image verification after programming. Linux only
:: | debug             | no        | false                                         | Verbose mode for printing additional information
:: | capacity          | no        | 1 MB                                          | Serial flash capacity for format operation
:: | spPath            | no        | String indicating the path                    | Indicates the path to the service pack file
:: | getVersion        | no        | N/A                                           | Getting the boot loader version of the device
:: | format            | no        | N/A                                           | Serial flash format
:: | program           | no        | N/A                                           | Programming of any element except from service pack
:: | servicePackUpdate | no        | N/A                                           | Service pack programming
:: | imageProgramming  | no        | N/A                                           | Image Programming
:: +-------------------+-----------+-----------------------------------------------+-----------------------------------------------------------------+
::
:: Example:
:: uf.bat -config "C:\ti\uniflash_3.2\cc3xxx\sessions\uniflash_template\oob.ucf" -setOptions com=50 secure=false spPath="C:\servicepack.bin" -operations format servicePackUpdate program
:: uf.bat -config "C:\Cygwin\home\robbie\GitHub\cc3200\SDK\CC3200\example\out_of_box\html\out_of_box.ucf" -setOptions com=8 secure=false spPath="C:\TI\CC31xx_CC32xx_ServicePack_1.0.0.10.0\servicepack_1.0.0.10.0.bin" -operations format servicePackUpdate program
