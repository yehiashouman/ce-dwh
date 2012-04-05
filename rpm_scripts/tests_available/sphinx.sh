#!/bin/bash - 
#===============================================================================
#          FILE: sphinx.sh
#         USAGE: ./sphinx.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:31:21 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo -e "\n********Sphinx********\n"
echo "Sphinx port [9312]:"
read SPH_PORT
if [ -z "$SPH_PORT" ];then 
    SPH_PORT=9312
fi
if ! `netstat -ltu --numeric-ports | grep -q ":$SPH_PORT"`;then
    echo -e "${SETCOLOR_SUCCESS}OK: port $SPH_PORT is free.$SETCOLOR_NORMAL"
else
    echo -e "${SETCOLOR_FAILURE}ERROR: there's a listener on $SPH_PORT.$SETCOLOR_NORMAL"
fi

