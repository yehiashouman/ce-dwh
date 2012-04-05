#!/bin/bash - 
#===============================================================================
#          FILE: needed_executables.sh
#         USAGE: ./needed_executables.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:25:51 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error
RC=0
for BIN in rsync curl convert wget nmap telnet dig ping java ssh ifconfig mount umount cat head tail less top uptime;do
    echo "Is $BIN executable...?"
    which $BIN
    RC=$?
    if [ $RC -eq 0 ];then
	echo -e "${SETCOLOR_SUCCESS}OK: $BIN exists and is executable.$SETCOLOR_NORMAL"
    else
	echo -e "${SETCOLOR_FAILURE}ERROR: I couldn't find $BIN.$SETCOLOR_NORMAL"
    fi
done

