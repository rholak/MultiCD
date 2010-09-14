#!/bin/sh
set -e
#Ubuntu Custom #2 plugin for multicd.sh
#version 5.8
#Copyright (c) 2010 maybeway36
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
if [ $1 = scan ];then
	if [ -f ubuntu2.iso ];then
		echo "Ubuntu Custom #2 (for using multiple versions on one disc - 9.10 or newer)"
		echo > tags/ubuntu2
	fi
elif [ $1 = copy ];then
	if [ -f ubuntu2.iso ];then
		echo "Copying Ubuntu Custom #2..."
		plugins/ubuntu-common.sh ubuntu2
	fi
elif [ $1 = writecfg ];then
if [ -f ubuntu2.iso ];then
cat >> multicd-working/boot/isolinux/isolinux.cfg << EOF
label ubuntu2
menu label --> Ubuntu Custom #2 Menu
com32 menu.c32
append /boot/ubuntu2/ubuntu2.cfg

EOF
cat >> multicd-working/boot/ubuntu2/ubuntu2.cfg << EOF

label back
menu label Back to main menu
com32 menu.c32
append /boot/isolinux/isolinux.cfg
EOF
if [ -f tags/ubuntu2.name ] && [ "$(cat tags/ubuntu2.name)" != "" ];then
	perl -pi -e "s/Ubuntu\ Custom\ \#2/$(cat tags/ubuntu-custom2.name)/g" multicd-working/boot/isolinux/isolinux.cfg
fi
fi
else
	echo "Usage: $0 {scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi
