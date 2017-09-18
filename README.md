# BuildRoot Linux/OS Building System


## Overview

This is a 2nd level fork of the [BuildRoot Project.](https://buildroot.org/) The direct fork is from [JumpNow's project,](http://www.jumpnowtek.com/) which incorporates [several great changes](http://www.jumpnowtek.com/rpi/Raspberry-Pi-Systems-with-Buildroot.html) to the master BuildRoot system. At it's core, the BuildRoot project allows for compiling Linux to run on different platforms, and then compiling any additional tools that are needed by applications, users, or the system itself. By tightly controlling the programs and utilities that are installed, the process of creating a small but capable embedded system can be achieved and then ported between different hardware. These application engines can then form an ecosystem of devices/abilities to suit a particular end-use case. The current DEFCONFIG is geared towards a Raspberry Pi but can quickly be shifted to another supported SoC.


## Using
  1. Clone this repository.
  2. Enter the repo and run 'git checkout mbay'
  3. Run 'make mbay_rpi3_defconfig'
  4. Run 'make'
  5. When the build is finished, copy "output/images/rpi-sdcard.img" to an SD card
  6. Insert the SD card into the Raspberry Pi and power on with a serial cable on GPIOs 14/15/GND

  
## Details

### JumpNow Changes
The changes made by JumpNow (and kept here) are the following:
  - Addition of Raspberry Pi Wi-Fi firmwares from non-free sources
  - Linux kernel and Raspberry Pi firmware moved to 4.9
  - Sample FS overlays provided (sysinit, etc)
  - Build patches download and compile Device Tree Blobs from source

### SwissArmyBud Changes
The changes made by this repo are as follows:
  - Added Raspberry Pi BlueTooth firmware download/compile
    - Plus Bluez5, Bluez Tools, ConnMan, BMon
  - Added "ifupdown" and associated scripts
  - Added "SystemV" init system skeleton
  - Full Node.js and NPM support, plus PM2
  - Full Git, Curl, and WGet support
  - Both Vim and Nano included
  - Full RTSP/Camera Streaming Support:
    - Compile/install "_x" VideoCore .elf and .dat for Raspberry Pi camera support
	- Compile/install custom [V4L2cpp](https://github.com/mpromonet/libv4l2cpp/) package
	- Compile/install custom [V4L2rtsp](https://github.com/mpromonet/v4l2rtspserver) package
  - Embedded System Boot and Update Utilities
    - [SWupdate](https://github.com/SwissArmyBud/swupdate) (custom fork)
	  - [SWupdated](https://github.com/SwissArmyBud/SWupdated) add-on
	- [UBoot](https://github.com/u-boot/u-boot)
	  - [SafeBoot](https://github.com/SwissArmyBud/SafeBoot) add-on


# --- ORIGINAL DOCUMENTATION BELOW ---
Buildroot is a simple, efficient and easy-to-use tool to generate embedded
Linux systems through cross-compilation.

The documentation can be found in docs/manual. You can generate a text
document with 'make manual-text' and read output/docs/manual/manual.text.
Online documentation can be found at http://buildroot.org/docs.html

To build and use the buildroot stuff, do the following:

1) run 'make menuconfig'
2) select the target architecture and the packages you wish to compile
3) run 'make'
4) wait while it compiles
5) find the kernel, bootloader, root filesystem, etc. in output/images

You do not need to be root to build or run buildroot.  Have fun!

Buildroot comes with a basic configuration for a number of boards. Run
'make list-defconfigs' to view the list of provided configurations.

Please feed suggestions, bug reports, insults, and bribes back to the
buildroot mailing list: buildroot@buildroot.org
You can also find us on #buildroot on Freenode IRC.

If you would like to contribute patches, please read
https://buildroot.org/manual.html#submitting-patches
