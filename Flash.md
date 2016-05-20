# How to Flash Image

## Command Line

### Flash by Path From Top

```
$ cd project_root_dir
$ ./f32.bat COM# [app] [option]

Usage:
f32.bat COM# [app] [option]
* COM#:
    - Number of COM port, (1~255)
* config:
    - App path, relative path in unix format, eg Apps/hello/program.usf
* option:
    - F - foramt
    - S - servicePackUpdate
    - P - program
    - FS
    - FSP (default)

Example:
$ ./f32.bat 8 Apps/hello/program.usf P
$ ./f32.bat 8 Apps/prebuilt/program.usf FSP
$ ./f32.bat 8 SDK/CC3200/example/out_of_box/html/out_of_box.ucf
```

<span style="color:red">
**Flash image in this way MUST have config file and the associated session for UniFlash. Example as below:**

**Support Cygwin ONLY.**
</span>

```
$ ls -l Apps/hello
total 37
drwxr-xr-x+ 1 robbie None    0 May 20 13:50 exe
-rwxr-xr-x  1 robbie None 1265 May 20 19:08 flash.bat       (* flash script)
-rw-r--r--  1 robbie None 1120 May 20 13:37 linker.ld
-rw-r--r--  1 robbie None 7340 May 20 13:37 main.c
-rw-r--r--  1 robbie None 1805 May 20 13:37 Makefile
-rw-r--r--  1 robbie None 1805 May 20 13:37 Makefile.old
drwxr-xr-x+ 1 robbie None    0 May 20 13:50 obj
-rw-r--r--  1 robbie None 3038 May 20 13:37 pinmux.c
-rw-r--r--  1 robbie None 2197 May 20 13:37 pinmux.h
-rw-r--r--  1 robbie None  101 May 20 14:26 program.ucf     (* config 1)
-rw-r--r--  1 robbie None  729 May 20 16:26 program.usf     (* config 2)
drwxr-xr-x+ 1 robbie None    0 May 20 13:50 program_session (* session)
```

### Flash by App

```
$ cd project_root_dir
$ cd Apps/hello
$ ./flash.bat COM# [option]
; option - F/S/P/FS/FSP(default)
```

<span style="color:red">
**This way ONLY works in applications with `flash.bat` script. Example as above `Apps/hello`.**

**It works for both Cygwin and Windows CMD.**
</span>

### More Flexible Way

```
$ uf.bat [CONFIG] [SETTINGS] [OPERATION]

Usage:
uf.bat [CONFIG] [SETTINGS] [OPERATION]
uf.bat -help

[CONFIG]:
    -config <configPath>

[SETTINGS]
    -listOptions
    -setOptions <OptID1>=<Value1> ... <OptIDN>=<ValueN>

[OPERATION]
    -listOperations
    -operation <opCode1> ... <opCodeN>

<End of command>
```


The following table summarizes all command line arguments:

 Argument          | Required? | Default                                | Description
-------------------|-----------|----------------------------------------|-----------------------------------------------------------------
 config            | yes       | N/A                                    |
 listOptions       | no        | N/A                                    |
 listOperations    | no        | N/A                                    |
 com               | no        | Decimal number indicating the COM port | Indicates the COM port to be used when connecting to the device
 imagePath         | no        | String indicating the path             | Indicates the path to the image file
 imageVerify       | no        | false                                  | Image verification after programming. Linux only
 debug             | no        | false                                  | Verbose mode for printing additional information
 capacity          | no        | 1 MB                                   | Serial flash capacity for format operation
 spPath            | no        | String indicating the path             | Indicates the path to the service pack file
 getVersion        | no        | N/A                                    | Getting the boot loader version of the device
 format            | no        | N/A                                    | Serial flash format
 program           | no        | N/A                                    | Programming of any element except from service pack
 servicePackUpdate | no        | N/A                                    | Service pack programming
 imageProgramming  | no        | N/A                                    | Image Programming

Example:

```
$ uf.bat -config "C:\ti\uniflash_3.2\cc3xxx\sessions\uniflash_template\oob.ucf" \
  -setOptions com=50 secure=false spPath="C:\servicepack.bin" \
  -operations format servicePackUpdate program
$ uf.bat -config "C:\Cygwin\home\robbie\GitHub\cc3200\SDK\CC3200\example\out_of_box\html\out_of_box.ucf" \
  -setOptions com=8 secure=false \
  spPath="C:\TI\CC31xx_CC32xx_ServicePack_1.0.0.10.0\servicepack_1.0.0.10.0.bin" \
  -operations format servicePackUpdate program
```

<span style="color:red">
**It works for both Cygwin and Windows CMD.**
</span>

## GUI

Refer to [CC31xx & CC32xx UniFlash](http://processors.wiki.ti.com/index.php/CC31xx_%26_CC32xx_UniFlash#Command_Line_support).


## Reference

- http://processors.wiki.ti.com/index.php/CC31xx_%26_CC32xx_UniFlash
- http://processors.wiki.ti.com/index.php/CC3100_%26_CC3200_Serial_Flash_Guide

