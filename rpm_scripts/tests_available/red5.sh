#!/bin/bash - 
#===============================================================================
#          FILE: red5.sh
#         USAGE: ./red5.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:59:31 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error
RC=0
echo -e "\n********Red5********\n"
if [ ! -x "`which nc 2>/dev/null`" ];then
    echo -e "${SETCOLOR_FAILURE}I need the nc util to run this test. Aborting.$SETCOLOR_NORMAL"
else
    echo "Red5 server:"
    read RED5
    for PORT in 9999 5080 1935;do
	nc $RED5 $PORT -w3
	if [ $? -ne 0 ];then
	    echo -e "${SETCOLOR_FAILURE}ERROR: Port $PORT has no listener.$SETCOLOR_NORMAL"
	fi
    done
fi

