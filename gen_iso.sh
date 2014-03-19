#!/bin/sh
# arg1: iso name
# arg2: cdrom device

if [ -f ~/.attoolsrc ]
then
   source ~/.attoolsrc
else
   cddev=unset
fi

# if cd device not specified use the one from the rc file
if [ -z $2 ]
then
   DEVICE=$cddev
else
   DEVICE=$2
fi

if [ $DEVICE = 'unset' ]
then
   echo device not set
	exit 1
fi

ddrescue -b 2048 -n $DEVICE $1 $1.log