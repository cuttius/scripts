#!/bin/sh
# Brett 'cuttius' May
# palm-detect-xinput
# This is a small script that uses xinput to control palm dectection.

if [ "$#" -gt 1 ]; then
	echo 'Usage: palm-detect-xinput [ on | off ]'
	echo 'No arguments will print status.'
fi

if ! type xinput > /dev/null; then
	echo 'Unable to find xinput.'
fi

touchpadID=$(xinput | grep 'SynPS' | cut -f 2 | cut -d '=' -f 2)

if [ -z "$touchpadID" ]; then
	echo 'Unable to find touchpad'
	exit	
fi

touchpadState=$(xinput list-props $touchpadID | grep 'Typing Enabled (' | cut -f 3)

if [ -z "$touchpadState" ]; then
	echo 'Unable to read touchpad state'
	exit	
fi

if [ $# -lt 1 ]; then
	case $touchpadState in
		'0') echo 'Palm detect is off';;
		'1') echo 'Palm detect is on';;
		*) echo 'Unable to read touchpad state';;
	esac
fi

if [ $# -eq 1 ]; then
	case $1 in
		on) xinput --set-prop $touchpadID "libinput Disable While Typing Enabled" 1
			echo 'Palm detect is now on' 
			exit;;
		off) xinput --set-prop $touchpadID "libinput Disable While Typing Enabled" 0
			echo 'Palm detect is now off'
			exit;;
		*) echo 'Usage: palm-detect-xinput [ on | off ]'
			echo 'No arguments will print status.'
			exit;;
	esac
fi