# Gentoo on Olimex Teres 1 DIY laptop

DIY laptop is amazing!

Building a usable linux on Teres 1 needs some patching, custom scripts and ebuilds. This repo hosts configuration files and local overlay for a Gentoo build with LXDE, Chromium, LaTeX, Gimp, LibreOffice, Vim, Java, etc. This is a lightweight but functional desktop.

![This must stop!](https://raw.githubusercontent.com/khumarahn/teres1-gentoo/master/screen.1.png)

C and C++ programs are compiled for Cortex-a53 with
```
CFLAGS="-O2 -pipe -march=armv8-a+crypto+crc -mtune=cortex-a53"
CXXFLAGS="${CFLAGS}"
```
With distcc, it takes around three days to compile everything.

## Download

Download the image here: ![Torrent](https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20171120.img.xz.torrent).

Unpack it and burn to a microsd card:
```
dd if=teres-gentoo-20171119.img of=/dev/sdx status=progress
```
Plug the card in and boot. Default user is `tux`, password is `olimex`. Root password is `olimex` too.

If you feel there is not much free space, try using a larger sd card and resizing the system partition and/or remove texlive.

To install to MMC, replace the contents of your `/dev/mmcblk0p1` and `/dev/mmcblk0p2` with what is in the respective partitions in the image. Then edit `/etc/fstab` and `/boot/uEnv.txt`.

## Notes:
* For the sleep button to work (Fn+F1), update the keyboard firmware, see https://github.com/d3v1c3nv11/TERES-KBD-RELEASE/tree/master/upgrade
* ACPI sleep, power button and brightness up/down events are controlled by acpid, they work regardless of the desktop environment, also without it in console. To change the behaviour, consult the very simple scripts in /etc/acpi/actions.
* Screenshots are handled by a script /usr/local/bin/screenshot.sh. It silently saves png to ~/screenshots. PrtScr saves the sholw screen, and Ctrl+PrtScr or Shift+PrtScr let you select a window.
* No systemd, because it complains about the old kernel. Using openrc instead.
* Battery indication is tricky, I had to patch lxpanel specifically for Teres. Currently it shows the charge (percentage) accurately, but does not estimate the remaining time.
* Linux kernel is stock, except I changed the governor to "ondemand" and disabled `CONFIG_SECCOMP` (for chromium and pulseaudio).
* Hdmi is not tested, I do not have the cable or the monitor.
