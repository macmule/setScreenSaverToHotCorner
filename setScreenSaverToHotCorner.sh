#!/bin/sh
####################################################################################################
#
# More information: http://macmule.com/2013/10/22/how-to-create-a-microsoft-remote-desktop-8-connection
#
# GitRepo: https://github.com/macmule/setScreenSaverToHotCorner
#
# License: http://macmule.com/license/
#
####################################################################################################
#
# DEFINE VARIABLES & READ IN PARAMETERS
#
##################################################################

# HARDCODED VALUES ARE SET HERE

# Choose (tl = top left, tr = top right, bl = bottom left or br = bottom right
hotCornerToUse=""

# CHECK TO SEE IF A VALUE WAS PASSED IN PARAMETER 4 AND, IF SO, ASSIGN TO "hotCornerToUse"
if [ "$4" != "" ] && [ "$hotCornerToUse" == "" ];then
	hotCornerToUse=$4
fi

##################################################################
#
# SCRIPT CONTENTS - DO NOT MODIFY BELOW THIS LINE
#
##################################################################

# Exit if no Hot Corner set
if [ "$hotCornerToUse" == "" ]; then
	echo "Error: The parameter 'hotCornerToUse' is blank. Please specify a Hot Corner To Use..."
	exit 1
fi

# Get the logged in users username
loggedInUser=`/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'`

# Reads plist to see if hot corners have been set (tl = top left)..
hctl=`defaults read /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-tl-corner`
hctr=`defaults read /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-tr-corner`
hcbl=`defaults read /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-bl-corner`
hcbr=`defaults read /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-br-corner`

# If hot corners have been set for the above.. then assign a value to hotcorners variable
if [[ "$hctl" = 5 ]]; then
	hotcornerset=$((hotcornerset+1))
fi

if [[ "$hctr" = 5 ]]; then
	hotcornerset=$((hotcornerset+1))
fi

if [[ "$hcbl" = 5 ]]; then
	hotcornerset=$((hotcornerset+1))
fi

if [[ "$hcbr" = 5 ]]; then
	hotcornerset=$((hotcornerset+1))
fi

if [[ "$hotcornerset" > 0 ]]; then
	echo "Hot Corner already set.."
else
	defaults write /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-$hotCornerToUse-corner -int 5
	defaults write /Users/$loggedInUser/Library/Preferences/com.apple.dock wvous-$hotCornerToUse-modifier -int 1
	chmod 777 /Users/$loggedInUser/Library/Preferences/com.apple.dock.plist
	killall Dock
	echo "Hot Corner set to $hotCornerToUse..."
fi
