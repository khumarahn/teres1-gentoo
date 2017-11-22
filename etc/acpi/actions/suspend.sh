#!/bin/bash

# make a lock file. A power button event wakes us up,
# then instead of powering off it deleted the lock file
suspend_lock=/run/lock/teres-suspend

touch "${suspend_lock}"

echo -n mem > /sys/power/state
