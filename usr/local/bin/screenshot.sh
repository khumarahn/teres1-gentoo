#!/bin/bash

DIR="${HOME}/screenshots"
DATE="$(date +%Y%m%d@%H%M%S)"
NAME="${DIR}/screenshot-${DATE}.png"
LOG="${DIR}/screenshots.log"

# Check if the dir to store the screenshots exists, else create it: 
if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi 

# Screenshot a selected window
if [ "$1" = "win" ]; then xwd | convert xwd:- "${NAME}"; fi

# Screenshot the entire screen
if [ "$1" = "scr" ]; then xwd -root | convert xwd:- "${NAME}"; fi

# Screenshot a selected area
# if [ "$1" = "area" ]; then s=1 scrot "${NAME}"; fi

if [[ $# = 0 ]]; then
  # Display a warning if no area defined
  echo "No screenshot area has been specified. Screenshot not taken."
  echo "${DATE}: No screenshot area has been defined. Screenshot not taken." >> "${LOG}"
else
  # Save the screenshot in the directory and edit the log
  echo "${NAME}" >> "${LOG}"
fi

