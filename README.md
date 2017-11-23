# Gentoo on Olimex Teres 1 DIY laptop

DIY laptop is amazing!

Building a usable linux on Teres 1 needs some patching and custom scripts. This repo hosts configuration files and local overlay for a Gentoo build with LXDE, Chromium, LaTeX, Gimp, LibreOffice, Vim, Java, etc. This is a lightweight but functional desktop.

![This must stop!](https://raw.githubusercontent.com/khumarahn/teres1-gentoo/master/screen.1.png)

C and C++ programs are compiled for Cortex-a53 by gcc-6.4.0 with
```
CFLAGS="-O2 -pipe -march=armv8-a+crypto+crc -mtune=cortex-a53"
CXXFLAGS="${CFLAGS}"
```
With distcc, it takes around three days to compile everything.

## Install

I feel that a proper manual is due. Maybe, an article on Gentoo's wiki. But if you ever installed Gentoo and you are adventurous enough to want Gentoo on Teres, you probably know what to do.

The kernel is special, and you may need to replace linux-headers with Teres' headers from the beginning. See my [package.provided](https://github.com/khumarahn/teres1-gentoo/blob/master/etc/portage/profile/package.provided) and [teres-headers](https://github.com/khumarahn/teres1-gentoo/tree/master/usr/local/portage/sys-kernel/teres-headers).

## Download

As a preview, you can download an image here: ![torrent](https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20171123.img.xz.torrent). I made it for myself for everyday use.
```
$ sha256sum teres-gentoo-20171123.img*
e5fe184b121941b36f0623566c5dc1de91a9f221cf9fc67fda00283c5a601a05  teres-gentoo-20171123.img
c648c60b32977a825f38459508c9ec1ca5a1e93348779f15d97c78e1df12f90e  teres-gentoo-20171123.img.xz
```

Unpack it and burn to a microsd card:
```
dd if=teres-gentoo-20171123.img of=/dev/sdX status=progress
```
Plug the card in and boot. Default user is `tux`, password is `olimex`. Root password is `olimex` too.

If you feel there is not much free space, try using a larger sd card and resizing the system partition and/or remove texlive.

To install to MMC, replace the contents of your `/dev/mmcblk0p1` and `/dev/mmcblk0p2` with what is in the respective partitions in the image. Then edit `/etc/fstab` and `/boot/uEnv.txt`.

## Notes:
* For the sleep button to work (Fn+F1), update the keyboard firmware, see https://github.com/d3v1c3nv11/TERES-KBD-RELEASE/tree/master/upgrade
* ACPI sleep, power button and brightness up/down events are controlled by acpid, they work regardless of the desktop environment, also without it in console. To change the behaviour, see the very simple scripts in /etc/acpi/actions.
* Screenshots are handled by the script `/usr/local/bin/screenshot.sh`. It silently saves png to `~/screenshots/`. PrtScr saves the whole screen, and Ctrl+PrtScr or Shift+PrtScr let you select a window.
* No systemd, because it complains about the old kernel. Using openrc instead.
* Battery indication is tricky, I had to patch lxpanel specifically for Teres. Currently it shows the charge (percentage) accurately, but does not estimate the remaining time.
* Linux kernel is stock, except I changed the governor to `ondemand` and disabled `CONFIG_SECCOMP` (for chromium and pulseaudio).
* Hdmi is not tested, I do not have the cable or the monitor.
* Bluetooth is not tested.
