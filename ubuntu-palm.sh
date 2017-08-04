#!/bin/sh
# Brett 'cuttius' May
# ubuntu-palm.sh
# This is just a small script to test if palm detect is turned on in
# synclient and let the user pick if they want it on or off.

currentPalm=$(synclient | grep 'PalmDetect' | cut -d '=' -f 2)
echo $currentPalm

if [ -z $1 ]
then
  case $currentPalm in
    0*) echo 'Palm Detect is off'
    ;;
    1*) echo 'Palm Detect is on'
    ;;
    *) echo 'Unable to test Palm Detect'
      ;;
  esac
fi

case $currentPalm in
  1*) echo 'Palm Detect is on'
    ;;
  0*) echo 'Palm Detect is off'
    ;;
esac

if [ $# -eq 1 ]
then
  case $1 in
    on) synclient PalmDetect=1
      echo ' PalmDetect is now on'
      exit;;
    off) synclient PalmDetect=0
      echo 'PalmDetect is now off'
      exit;;
    *) echo 'Usage: ubuntu-palm [ on | off ]'
      echo ' No argument will return status'
      exit;;
  esac
fi
