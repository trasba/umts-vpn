#!/bin/bash

BASEDIR=$(dirname $0)
dir1=/etc/umtskeeper/
#include functions file
if [ ! -x $BASEDIR/functions ]
then
chmod +x $BASEDIR/functions
fi
source $BASEDIR/functions 

read -p "Initial setup of UMTSKEEPER? (Y/N)" -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
  if [ -d ${dir1}]; then
  echo "Are your sure? The folder ${dir1} does exist. If you continue all files in these folder will be overwritten. Proceed? (Y/N) "
  read -p "Initial setup of UMTSKEEPER? (Y/N)" -n 1 -r
  echo ""
   if [[ $REPLY =~ ^[Yy]$ ]]; then
   baseSetup
   fi
  else
  baseSetup
  fi
fi
#read manufacturer and device id from modem (now only for huwaei)
#CHANGE take care that the modem is already switched (usb-modeswitch)
strUSBMODEM="$(lsusb | awk '{if ($7 == "Huawei") print $6;}')"
#write manufacturer and id into array arrUSBMODEM
#IFS=':' read -r -a arrUSBMODEM <<< $strUSBMODEM #get variable with ${arrUSBMODEM[0]}

#check if config file exists
strConfFile=config.cfg
if [ ! -f $BASEDIR/$strConfFile ]
then
source configfile
else
if [ ! -x $BASEDIR/$strConfFile ]
then
chmod +x $BASEDIR/$strConfFile
fi
$BASEDIR/$strConfFile
read -p "Use existing config file? (Y/N)" -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  configfile
fi
writeRcLocal
fi
