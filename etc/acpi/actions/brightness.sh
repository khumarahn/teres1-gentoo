#!/bin/bash

fcur="/sys/class/backlight/lcd0/brightness"
fmax="/sys/class/backlight/lcd0/max_brightness"

current=$(cat ${fcur})
max=$(cat ${fmax})

delta=$(( ${max} / 16 ))

if [ "$1" == "+" ] ; then
    new=$(( ${current} + ${delta} ))
    if [ $(echo "${new} > ${max}" | bc -l) -eq 1 ]; then
        echo "${max}" > "${fcur}"
    else
        echo "${new}" > "${fcur}"
    fi
elif [ "$1" == "-" ] ; then
    new=$(( ${current} - ${delta} ))
    if [ $(echo "${new} < 1" | bc -l) -eq 1 ]; then
        echo "1" > "${fcur}"
    else
        echo "${new}" > "${fcur}"
    fi
fi
