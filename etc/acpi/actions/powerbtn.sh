#!/bin/bash

suspend_lock=/run/lock/teres-suspend

if [ -f "${suspend_lock}" ] ; then
    # we are resuming from suspend: delete the lock file, restore sound,
    # do not shutdown
    /etc/init.d/alsasound restore
    rm "${suspend_lock}"
else
    /sbin/shutdown -h now "Power button pressed"
fi
