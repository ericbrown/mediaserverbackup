#!/bin/bash

#---------------------------------------------------------
# Author: Eric D Brown
# Version 1.0
# Script Tested on: 
# Ubuntu 14.04 on 4/19/2016	[ OK ] 
#---------------------------------------------------------
# Based on the "Backup a Plex database" script at 
# https://gist.github.com/ssmereka/8773626
# by Scott Smereka
#---------------------------------------------------------
user = "eric"

# Sonarr Location.  The trailing slash is 
# needed and important for rsync.
SonarrLocation = "/home/$user/.config/NzbDrone/"
echo SonarrLocation

# Location to backup the directory to.
backupDirectory="/home/backups/sonarr/backup/"

# Log file for script's output named with 
# the script's name, date, and time of execution.
scriptName=$(basename ${0})
log="/home/backups/sonarr/logs/${scriptName}_`date +%m%d%y%H%M%S`.log"

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
  echo -e "${scriptName} requires root privledges.\n"
  echo -e "sudo $0 $*\n"
  exit 1
fi

# Create Log
echo -e "Staring Backup of sonarr Database." > $log 2>&1
echo -e "Staring Backup of sonarr Database."
echo -e "------------------------------------------------------------\n" >> $log 2>&1

# Stop Plex
echo -e "\n\nStopping sonarr." >> $log 2>&1
echo -e "\n\nStopping sonarr." 
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo stop nzbdrone >> $log 2>&1

# Backup database
echo -e "\n\nStarting Backup." >> $log 2>&1
echo -e "\n\nStarting Backup." 
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo rsync -av --delete "$SonarrLocation" "$backupDirectory" >> $log 2>&1

# Restart Plex
echo -e "\n\nStarting sonarr." >> $log 2>&1
echo -e "\n\nStarting sonarr."
echo -e "------------------------------------------------------------\n" >> $log 2>&1
sudo start nzbdrone >> $log 2>&1

# Done
echo -e "\n\nBackup Complete." >> $log 2>&1
echo -e "\n\nBackup Complete."
