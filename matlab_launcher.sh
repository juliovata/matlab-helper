#!/bin/bash

# MATLAB executable name 
MATLAB="MATLAB Executable Here With Full Path"

# Directory MATLAB should open in when script is run without a file argument
DEFAULT_DIR=$HOME/Desktop

# Additional flags that you want passed when MATLAB is started
# I personally also use the -softwareopengl flag on my system
LAUNCH_FLAGS=

if [ $# -eq 0 ]
then
	cd "${DEFAULT_DIR}"
	${MATLAB} -desktop "${LAUNCH_FLAGS}"
else
	FILE_DIR=$(dirname "$1")
	FILENAME=$(basename "$1")

	cd "${FILE_DIR}"
	${MATLAB} -desktop "${LAUNCH_FLAGS}" -r "edit ${FILENAME}"
fi
