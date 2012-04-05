#!/bin/bash - 
#===============================================================================
#          FILE: preinst.sh
#         USAGE: ./preinst.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 20:09:39 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error
TESTS_ENABLED=`dirname $0`/tests_enabled
if [ $# -eq 1 ];then
    TESTS_ENABLED=$1
fi
if ! ls $TESTS_ENABLED/*.sh >>/dev/null 2>&1;then
    echo "No tests to run, exiting."
    exit 1
fi
TMPDIR=/tmp/`basename $0`_$$
mkdir -p $TMPDIR

COMMON_RC=`dirname $0`/common.rc
if [ -r $COMMON_RC ];then
    . $COMMON_RC
else
    echo "${SETCOLOR_FAILURE}Couldn't source $COMMON_RC. Aborting.$SETCOLOR_NORMAL"
    exit 1
fi
for SH in $TESTS_ENABLED/*.sh;do
    . $SH
done
rm -rf $TMPDIR
