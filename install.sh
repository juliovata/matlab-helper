#!/bin/bash

# check for argument
# TODO(juliovata) add flag for -softwareopengl during install
if [ $# -ne 1 ]
then
  echo "Usage:   install.sh [Full path to MATLAB Executable]"
  echo "Example: install.sh /home/usr/Programs/MATLAB/R20XXx/bin/glnxa64"
  exit 1
fi

# set executable path, icon image path, MATLAB version
MATLAB_PATH=$1

if [[ "${MATLAB_PATH}" =~ /(R20[0-9][0-9][a-z])/ ]]
then
  MATLAB_VERSION="${BASH_REMATCH[1]}"
else
  echo "${MATLAB_PATH} does not contain the MATLAB version substring, format R20[0-9][0-9][a-z]"
  exit 1
fi

# TODO(juliovata): if /home/$USER/bin does not exist, create the directory
mkdir -p ${HOME}/bin

# TODO(juliovata) back up existing matlab.desktop file if it exists
echo "Backing up current matlab.desktop file, if it exists..."

# Remove previous version and setup folder
echo "Removing previous version (if found)..."
rm -f ${HOME}/bin/matlab_launcher.sh
rm -f ${HOME}/.local/share/applications/matlab.desktop

echo "Downloading and Installing latest files..."

# TODO(juliovata) for now just cp relevant files from current directory
cp matlab_launcher.sh ${HOME}/bin/
cp matlab.desktop ${HOME}/.local/share/applications/

# Add MATLAB executable to matlab_launcher.sh
sed -i -e "s|\"MATLAB Executable Here With Full Path\"|${MATLAB_PATH}/MATLAB|g" ${HOME}/bin/matlab_launcher.sh

# Add current version, icon path, and script executable path to desktop file
sed -i -e "s|\"MATLAB Version Here\"|${MATLAB_VERSION}|g" ${HOME}/.local/share/applications/matlab.desktop

# TODO add option for using system icon versus default icon?
sed -i -e "s|\"Icon Path Here\"|${MATLAB_PATH}/cef_resources/matlab_icon.png|g" ${HOME}/.local/share/applications/matlab.desktop
sed -i -e "s|\"Executable Path Here\"|${HOME}/bin/matlab_launcher.sh|g" ${HOME}/.local/share/applications/matlab.desktop

chmod +x ${HOME}/bin/matlab_launcher.sh

# TODO(juliovata) add file associations