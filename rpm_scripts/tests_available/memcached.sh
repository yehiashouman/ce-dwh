#!/bin/bash- 
#===============================================================================
#          FILE: memcached.sh
#         USAGE: ./memcached.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:29:32 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo -e "\n********Memcached********\n"
if [ ! -x "`which nc 2>/dev/null`" ];then
    echo -e "${SETCOLOR_FAILURE}I need the nc util to run this test. Aborting.$SETCOLOR_NORMAL"
else
    RC=0
    echo "memcached port [11211]:"
    read MEM_PORT
    if [ -z "$MEMD_PORT" ];then 
	MEMD_PORT=11211
    fi
    echo "memcached server:"
    read MEMCACHED
    nc $MEMCACHED $MEMD_PORT -w3
    RC=$?
    if [ $RC -ne 0 ];then
	echo -e "${SETCOLOR_FAILURE}ERROR: Port $MEMD_PORT has no listener.$SETCOLOR_NORMAL"
    else
	echo -e "${SETCOLOR_SUCCESS}OK: memcached is answering on $MEMD_PORT.$SETCOLOR_NORMAL"
    fi
fi


