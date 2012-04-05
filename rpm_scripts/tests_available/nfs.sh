#!/bin/bash - 
#===============================================================================
#          FILE: nfs.sh
#         USAGE: ./nfs.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:33:55 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error
echo -e "\n********NFS Configuration********\n"
echo "NFS server and path [i.e: 10.0.0.138:/my/path/to/mount]:"
read NFS_PATH
mkdir -p $TMPDIR/nfs_mount_test
mount $NFS_PATH $TMPDIR/nfs_mount_test
RC=$?
if [ $RC -eq 0 ];then
    echo -e "${SETCOLOR_SUCCESS}OK: successfully mounted $NFS_PATH.${SETCOLOR_NORMAL}"
fi
