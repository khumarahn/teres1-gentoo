#!/bin/bash

# TODO: what if the laptop boots with the lid closed?
# probably, the keyboard and the lcd would be still enabled

# "open" or "close"
action="${@: -1}"

# usb bus id of keyboard+touchpad device
kbd="1-1.4"

# power for the lcd
lcd=/sys/class/backlight/lcd0/bl_power
lcd_off=1
lcd_on=0

case "${action}" in
    open)
        logger -t "acpi_lid:" "lid open, enabling usb ${kbd}, turning on lcd"
        echo "${kbd}" > /sys/bus/usb/drivers/usb/bind
        echo "${lcd_on}" > "${lcd}"
        ;;
    close)
        logger -t "acpi_lid:" "lid closed, disabling usb ${kbd}, turning off lcd"
        echo "${kbd}" > /sys/bus/usb/drivers/usb/unbind
        echo "${lcd_off}" > "${lcd}"
        ;;
    *)
        logger -t "acpi_lid:" "unknown option ${action}"
        ;;
esac
