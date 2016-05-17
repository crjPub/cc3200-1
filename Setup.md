# Development Environment Setup for CC3200

## Toolchain

- OS: Windows XP/7/10 64 bits
- Cygwin **32 bits**
- IAR for ARM / CCS / gcc for ARM (at least 1 of them)
- OpenOCD
- FTDI
- UniFlash

## Cygwin

<span style="color:red">
**必须安装32位版本！**
</span>

### 下载地址

http://cygwin.com/setup-x86.exe

> 安装过程中选择国内的mirror服务器（eg, **163**）
>
> 除mirror外其他选择默认选项即可

### Tools

除默认安装的package之外还需手动选择安装下列工具：

- git openssh vim
- wget curl
- ctags cscope
- dos2unix xxd screen
- gcc-core

> 可以稍后通过**apt-cyg**安装

### Install Cygwin Components from Command Line

For a more convenient installer, you may want to use **apt-cyg** as your package manager. Its syntax similar to **apt-get**, which is a plus. For this, follow the above steps and then use Cygwin Bash for the following steps:

    wget raw.github.com/transcode-open/apt-cyg/master/apt-cyg
    chmod +x apt-cyg
    mv apt-cyg /usr/local/bin

Now that apt-cyg is installed. Here are few examples of installing some packages:

    apt-cyg install nano
    apt-cyg install git
    apt-cyg install ca-certificates

Use apt-cyg to install frequent use tools:

    apt-cyg install git openssh vim wget curl ctags cscope dos2unix xxd screen gcc-core

> - https://github.com/transcode-open/apt-cyg
> - http://stackoverflow.com/questions/9260014/how-do-i-install-cygwin-components-from-the-command-line

### Cygwin Packages for CC3200

    $ apt-cyg install zip unzip autoconf automake libtool make subversion gcc-core gcc-g++ mingw-gcc-core mingw-gcc-g++ mingw-runtime

## GNU Tools for ARM Embedded Processors

### GCC for ARM

Download and run the latest version of gcc-arm-none-eabi-<version>-win32.exe/zip from https://launchpad.net/gcc-arm-embedded.

    $ cd ~
    $ wget https://launchpad.net/gcc-arm-embedded/5.0/5-2016-q1-update/+download/gcc-arm-none-eabi-5_3-2016q1-20160330-win32.zip
    $ unzip gcc-arm-none-eabi-5_3-2016q1-20160330-win32.zip
    $ mkdir Tools
    $ mv gcc-arm-none-eabi-5_3-2016q1-20160330-win32 Tools

   Add gcc-arm-none-eabi to PATH by adding the following lines into .bashrc/.zshrc

    export PATH=$PATH:$HOME/Tools/gcc-arm-none-eabi-5_3-2016q1-20160330-win32/bin

### Build OpenOCD for FTDI Interface

- Download the Open On-Chip Debugger (OpenOCD) source from http://sourceforge.net/projects/openocd/files/openocd/0.7.0/ Look for the zip file openocd-0.7.0.zip.
- Extract the OpenOCD source into the Cygwin directory (C:\Cygwin). This will create a directory called openocd-<version> (for example, C:\Cygwin\openocd-0.7.0) under the Cygwin directory containing all the OpenOCD source contents.
- Download the FTDI driver library (x86 [32-bit] zip version) at http://www.ftdichip.com/Drivers/CDM/CDM%20v2.10.00%20WHQL%20Certified.zip
- Extract the FTDI source into the path C:\Cygwin\openocd-<version> ftd2xx (for example, C:\Cygwin\openocd-0.7.0\ftd2xx).

    ```
    $ cd ~
    $ wget http://downloads.sourceforge.net/project/openocd/openocd/0.7.0/openocd-0.7.0.zip
    $ unzip openocd-0.7.0.zip
    $ wget http://www.ftdichip.com/Drivers/CDM/CDM%20v2.10.00%20WHQL%20Certified.zip
    $ unzip 'CDM v2.10.00 WHQL Certified.zip' -d ftd2xx
    ```

- Run the Cygwin terminal and change the directory to openocd-<version> (for example, by using a command such as: cd C:Cygwin/openocd-0.7.0).
- Run the following command:

    ```
    $ cd openocd-0.7.0
    $ ./configure --enable-maintainer-mode --disable-werror --disable-shared --enable-ft2232_ftd2xx --with-ftd2xx-win32-zipdir=../ftd2xx
    $ autoreconf --force --install
    $ make               # This may take several minutes.
    $ make install
    ```

## IAR for ARM

> TODO

## CCS

> TODO

## UniFlash

The Uniflash utility allows the end-users to communicate with the Simple Link device via a standard UART interface.

The Uniflash utility enables the following functionalities:

- GUI interface
- Flashing of files (including read back verification option)
- Service pack flashing
- Storage format
- Versioning reading for boot loader and chip ID
- CLI interface
- Automatic reset of the board with any operation. Automatic reset is applicable only to TI evaluation boards, CC3100 BoosterPack and CC3200 LaunchPad (Applies to Windows version only)
- Building and Flashing of configurations files (a file composed from a collection of parameters)
- Preparing offline image for gang programming and Image Programming via UART (not using direct flash programmers)
- Linux support

Installation steps refer to [CC31xx & CC32xx UniFlash Installation](http://processors.wiki.ti.com/index.php/CC31xx_%26_CC32xx_UniFlash#Installation).

## Image Download

The CC3200 can be set to operate in three different modes based on the state of the Sense on Power (SOP) lines.

<span style="color:red">
**To download image to CC3200 LaunchPad, SOP\[2:0\] (J15-J17) MUST be set as `100` (short J15) to be flash programming mode.**
</span>

## Reference

- http://www.ti.com/lit/ug/swru376d/swru376d.pdf
- http://www.ti.com/lit/ug/swru372b/swru372b.pdf
- http://processors.wiki.ti.com/index.php/CC31xx_%26_CC32xx
- http://processors.wiki.ti.com/index.php/CC31xx_%26_CC32xx_UniFlash
- http://processors.wiki.ti.com/index.php/CC3100_%26_CC3200_Serial_Flash_Guide


