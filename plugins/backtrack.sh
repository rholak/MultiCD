#!/bin/sh
set -e
. $MCDDIR/functions.sh
#BackTrack plugin for multicd.sh (designed for BackTrack 4)
#version 6.6
#Copyright (c) 2011 Isaac Schemm
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
if [ $1 = links ];then
	echo "BT5-*.iso backtrack.iso none"
elif [ $1 = scan ];then
	if [ -f backtrack.iso ];then
		echo "BackTrack"
	fi
elif [ $1 = copy ];then
	if [ -f backtrack.iso ];then
		echo "Copying BackTrack..."
		ubuntucommon backtrack
	fi
elif [ $1 = writecfg ];then
	if [ -f backtrack.iso ];then
		if [ -f backtrack.version ] && [ "$(cat backtrack.version)" != "" ];then
			VERSION=" $(cat backtrack.version)" #Version based on isoaliases()
		else
			VERSION=""
		fi

		echo "label backtrack
		menu label --> BackTrack$VERSION Menu
		com32 menu.c32
		append /boot/backtrack/backtrack.cfg
		" >> $WORK/boot/isolinux/isolinux.cfg
	fi
else
	echo "Usage: $0 {scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi
