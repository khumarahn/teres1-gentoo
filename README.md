# Gentoo on Olimex Teres 1 DIY laptop

DIY laptop is amazing!

Building a usable linux on Teres 1 needs some patching and custom scripts. This repo hosts configuration files and a local overlay for a Gentoo build with LXDE, Chromium, Gimp, LibreOffice, Vim, Java, etc. This is a lightweight but functional desktop.

![This must stop!](https://raw.githubusercontent.com/khumarahn/teres1-gentoo/master/screen.1.png)

C and C++ programs are compiled for Cortex-a53 by gcc 7 and clang 5 with
```
CFLAGS="-O2 -pipe -march=armv8-a+crypto+crc -mtune=cortex-a53"
CXXFLAGS="${CFLAGS}"
```
With distcc, it takes around three days to compile everything.

## Install

Gentoo is the most suitable operating system for Teres 1: both do not come ready for use, but require time and patience to assemble. Both give a user comparatively strong control of what's under the hood. So I think that a proper manual is due, maybe an article on Gentoo's wiki.

For now, if you ever installed Gentoo, you probably know where to start. Right, download or build stage 3 and chroot. Or maybe replace the filesystem on the stock Ubuntu image with your stage 3? I hope that this repo will be helpful: you can find here already written ebuilds, or for example the acpi scripts.

The kernel is special, and you may need to replace linux-headers with Teres' headers from the beginning. See my [package.provided](https://github.com/khumarahn/teres1-gentoo/blob/master/etc/portage/profile/package.provided) and [teres-headers](https://github.com/khumarahn/teres1-gentoo/tree/master/usr/local/portage/sys-kernel/teres-headers).

## Download
Here is the image that I built for myself for everyday use:
* November 28, 2017: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20171128.img.xz.torrent
* February 15, 2018: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20180215.img.xz.torrent (Updates: 17.0 profile, gcc 7.3, headphones detection fixes, newer versions of many packages.)
* March 16, 2018: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20180316.img.xz.torrent (Updates: set up for a binary repo, a few updates and fixes) 
* April 26, 2018: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20180426.img.xz.torrent (Updates: f2fs for the win; some updates and simplifications) 
```
# sha256sum teres-gentoo*.img*
f5934c93aa2755c8275123864829fea64c8f5595d9c456a94b2fb79969fc2686  teres-gentoo-20171128.img
55ec4b024f6484f09caf40af3a16a1a8ddf325e7108736569959c5205e3cb6a5  teres-gentoo-20171128.img.xz
43e01f7cf7f5c2197ad1b5d9c5516a66465a7214945c712cbd77c89a5c7645f7  teres-gentoo-20180215.img
c74ae08bae8cb5f61cc4595509e2456504d23eaa5c0ea1be815fa1f329115ca6  teres-gentoo-20180215.img.xz
1543576506e1b3775d7ec5323ce0359e2d66dd2bfa731af65c33b48a27d86ec9  teres-gentoo-20180316.img
d5328730b3ce62bc3305e99bbcba8499fae857eb0f970132c16aecf531cc73d6  teres-gentoo-20180316.img.xz
330e2230420d12e4e6997a56f9538009135a891ab4e4a1bc9da8f3f02df9ccd3  teres-gentoo-20180426.img
a9073851a32fa718ebb3599fca2c3d96d40148bafeb328cbe91a390c083535e6  teres-gentoo-20180426.img.xz
```

Unpack the image and burn it to a microsd card:
```
dd if=teres-gentoo-20180426.img of=/dev/sdX status=progress
```
Plug the card in and boot. Default user is `tux`, password is `olimex`. Root password is `olimex` too.

To install to MMC, replace the contents of your `/dev/mmcblk0p1` and `/dev/mmcblk0p2` with what is in the respective partitions in the image. Then edit `/etc/fstab` and `/boot/uEnv.txt`.

## Binary repo
Compilation on Teres 1 is slow, sometimes even distcc does not help. I set up a binary repo on my vps. It holds a snapshot of portage and some prebuilt packages. The settings are in `/etc/portage/repos.conf/gentoo.conf`:
```
sync-uri = rsync://163.172.132.71/teres-portage
```
and in `/etc/portage/make.conf`:
```
PORTAGE_BINHOST="rsync://163.172.132.71/teres-portage-full/packages"
```
Change/remove the two likes above to use the official Gentoo repos.

To install a binary program, make sure that your use flags, keywords and masks correspond to those I use, and run for example
```
emerge -av --getbinpkg kicad
```

## Notes:
* For the sleep button to work (Fn+F1), update the keyboard firmware, see https://github.com/d3v1c3nv11/TERES-KBD-RELEASE/tree/master/upgrade
* ACPI sleep, power button and brightness up/down events are controlled by acpid, they work regardless of the desktop environment, also without it in console. To change the behaviour, see the very simple scripts in /etc/acpi/actions.
* Screenshots are handled by the script `/usr/local/bin/screenshot.sh`. It silently saves png to `~/screenshots/`. PrtScr saves the whole screen, and Ctrl+PrtScr or Shift+PrtScr let you select a window.
* No systemd, because it complains about the old kernel. Using openrc instead.
* Battery indication is tricky, I had to patch lxpanel specifically for Teres. Currently it shows the charge (percentage) accurately, but does not estimate the remaining time.
* Linux kernel is stock, except I changed the governor to `ondemand`, disabled `CONFIG_SECCOMP` (for chromium and pulseaudio) and compiled in f2fs.
* Hdmi is not tested, I do not have the cable or the monitor.
* Bluetooth is not tested.
