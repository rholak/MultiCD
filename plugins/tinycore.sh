#!/bin/sh
set -e
. $MCDDIR/functions.sh
#Tiny Core Linux plugin for multicd.sh
#version 6.1
#Copyright (c) 2010 Isaac Schemm
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
	echo "tinycore-current.iso tinycore.iso none"
	echo "tinycore_*.iso tinycore.iso none"
elif [ $1 = scan ];then
	if [ -f tinycore.iso ];then
		echo "Tiny Core Linux"
		#touch $TAGS/tinycore.needsname #Comment out this line and multicd.sh won't ask for a custom name for this ISO
	fi
elif [ $1 = copy ];then
	if [ -f tinycore.iso ];then
		echo "Copying Tiny Core..."
		tinycorecommon tinycore
	fi
elif [ $1 = writecfg ];then
#BEGIN TINY CORE ENTRY#
if [ -f tinycore.iso ];then
	if [ -f $TAGS/tinycore.name ] && [ "$(cat $TAGS/tinycore.name)" != "" ];then
		TCNAME=$(cat $TAGS/tinycore.name)
	elif [ -f tinycore.defaultname ] && [ "$(cat tinycore.defaultname)" != "" ];then
		TCNAME=$(cat tinycore.defaultname)
	else
		TCNAME="Tiny Core Linux"
	fi
	if [ -f tinycore.version ] && [ "$(cat tinycore.version)" != "" ];then
		TCNAME="$TCNAME $(cat tinycore.version)"
	fi
	for i in $(ls $WORK/boot/tinycore|grep '\.gz');do
		echo "label tinycore-$i
		menu label ^$TCNAME
		kernel /boot/tinycore/bzImage
		append quiet
		initrd /boot/tinycore/$(basename $i)">>$WORK/boot/isolinux/isolinux.cfg
	done
fi
#END TINY CORE ENTRY#
else
	echo "Usage: $0 {links|scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi
