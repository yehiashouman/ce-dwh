#!/bin/bash - 
#===============================================================================
#          FILE: apache_mods.sh
#         USAGE: ./apache_mods.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:16:36 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo -e "\n********Apache Configuration********\n"
RC=0
get_apachectl
$APACHE_CTL -t -D DUMP_MODULES >"$TMPDIR/apache_modules"
for MODULE in rewrite headers expires filter deflate file_cache env proxy;do
    if ! `grep -qi $MODULE $TMPDIR/apache_modules`;then
	echo -e "${SETCOLOR_FAILURE}ERROR: Apache module: $MODULE is not loaded.$SETCOLOR_NORMAL"
	RC=1
    else
	echo -e "${SETCOLOR_SUCCESS}OK: Apache module: $MODULE is loaded.$SETCOLOR_NORMAL"
    fi
done
