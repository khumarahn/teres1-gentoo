#!/bin/bash

suspend_lock=/run/lock/teres-suspend

# test if we are resuming, delete the lock file then instead of the shutdown
rm "${suspend_lock}" || /sbin/shutdown -h now "Power button pressed"

