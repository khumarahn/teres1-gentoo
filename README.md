# Gentoo on Olimex Teres 1 DIY laptop

DIY laptop is amazing!

![This must stop!](https://raw.githubusercontent.com/khumarahn/teres1-gentoo/master/screen.1.png)

Gentoo is the best operating system for a DIY computer: both require time and patience, and both pay back with strong control of what's under the hood.

This repo hosts various configuration files for a Gentoo build on Teres 1 with LXDE, Chromium, Gimp, LibreOffice, Vim, Java, etc. This is a lightweight but functional desktop.

## Download
Here is a compiled image which you can run from a micro-sd card, or install to the MMC.
* April 26, 2018: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20180426.img.xz.torrent (Updates: f2fs for the win; some updates and simplifications) 
* September 26, 2018: https://github.com/khumarahn/teres1-gentoo/raw/master/teres-gentoo-20180926.img.xz.torrent (Updates: encrypted `/home`, squashed portage, `deadline` io scheduler, gcc-8, clang-7, kicad-5, etc)
```
# sha256sum teres-gentoo*.img*
330e2230420d12e4e6997a56f9538009135a891ab4e4a1bc9da8f3f02df9ccd3  teres-gentoo-20180426.img
a9073851a32fa718ebb3599fca2c3d96d40148bafeb328cbe91a390c083535e6  teres-gentoo-20180426.img.xz
c218d22520c5212f2a48576b78d0e1640ae5cb9d2c177da5fcfb110c76a13bb9  teres-gentoo-20180926.img
725af8b2a266f04f6d22143ca90218f78bbc2427b99b1a614c5b6d13dd224b0e  teres-gentoo-20180926.img.xz
```

Unpack the image and burn it to a micro-sd card:
```
dd if=teres-gentoo-20180926.img of=/dev/sdX oflag=direct status=progress
```
Insert the card and boot. The default user is `tux`, password is `olimex`. Root's and `/home` passwords are `olimex` too.

To install to MMC, replace the contents of your `/dev/mmcblk0p1` and `/dev/mmcblk0p2` with what is in the respective partitions of the image (using, say, `rsync -aAxXhH`. Then edit `/etc/fstab` and `/boot/uEnv.txt` to point to right partitions.

## Encryption
The whole `/home` folder is encrypted with ![encfs](https://github.com/vgough/encfs). A password is asked on boot (`olimex` by default). The encfs is not perfect: the filenames and content are encrypted, but the directory structure, file sizes and attributes are not. But it is more flexible than dmcrypt, where one needs to allocate a fixed size container.

## Binary repo
Compilation on Teres 1 is slow, so I compile on my amd64 desktop in an arm64 qemu chroot. Then I install packages from a binary repo, which holds a snapshot of portage and many prebuilt packages. The settings are in `/etc/portage/repos.conf/gentoo.conf`:
```
sync-uri = rsync://khu.dedyn.io/teres-portage
```
and in `/etc/portage/make.conf`:
```
PORTAGE_BINHOST="rsync://khu.dedyn.io/teres-portage-full/packages"
```
Change/remove the two lines above to use the official Gentoo repos.

To install a program, make sure that your use flags, keywords and masks correspond to those I use, and run for example
```
emerge -av --getbinpkg kicad
```

## Notes:
* The kernel is very old and special, and you may need to replace linux-headers with Teres' headers from the beginning. See my [package.provided](https://github.com/khumarahn/teres1-gentoo/blob/master/etc/portage/profile/package.provided) and [teres-headers](https://github.com/khumarahn/teres1-gentoo/tree/master/usr/local/portage/sys-kernel/teres-headers).
* For the sleep button to work (Fn+F1), update the keyboard firmware, see https://github.com/d3v1c3nv11/TERES-KBD-RELEASE/tree/master/upgrade
* ACPI sleep, power button and brightness up/down events are controlled by acpid, they work regardless of the desktop environment, also without it in console. To change the behaviour, see the very simple scripts in /etc/acpi/actions.
* Screenshots are handled by the script `/usr/local/bin/screenshot.sh`. It silently saves png to `~/screenshots/`. PrtScr saves the whole screen, and Ctrl+PrtScr or Shift+PrtScr let you select a window.
* No systemd, because it complains about the old kernel. Using openrc instead.
* Battery indication is tricky, I had to patch lxpanel specifically for Teres. Currently it shows the charge (percentage) accurately, but does not estimate the remaining time.
* Linux kernel is stock, except I changed the cpu governor to `ondemand`, disabled `CONFIG_SECCOMP` (for chromium and pulseaudio), compiled in f2fs and changed the default io governor to `deadline`.
* Hdmi is not tested, I do not have the cable or the monitor.
* Bluetooth is not tested.
* There is a bug in lxpanel with rendering system tray icons with transparent background. I did not find what causes it, but it is a minor inconvenience.
