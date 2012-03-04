#!/bin/bash - 
#===============================================================================
#          FILE: kaltura_postinst.sh
#         USAGE: ./kaltura_postinst.sh 
#   DESCRIPTION: To be run post RPM installation 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy <jess.portnoy@kaltura.com>
#  ORGANIZATION: Kaltura, inc. 
#       CREATED: 02/23/12 16:22:30 IST
#      REVISION:  ---
#===============================================================================

if [ `id -u` -ne 0 ];then
    echo "You must be super user [root] to run this script"
    exit 1
fi

FUNCTS_FILE="`dirname $0`/common.rc"
if [ -r $FUNCTS_FILE ];then
    . $FUNCTS_FILE
else
    echo "Couldn't find $FUNCTS_FILE. Aborting."
fi

RC_FILE=/etc/kaltura.rc
if [ -r $RC_FILE ];then
    . $RC_FILE
    back_up_kalt_rc
#else
#    echo "Couldn't find $RC_FILE. Aborting."
fi

(cat << EOF
Welcome to $PRODUCT $VERSION post installation script!
In order to complete $PRODUCT configuration, answer a few questions about your environment.


What type of configuration would you like to apply on this server?
Please input the number for your desired installation.

0 Standalone server [all in 1]
1 Batch server
2 DB server
3 Sphinx server 
4 Data warehouse
5 KMC server
6 Admin console

EOF
)

read INST_TYPE
case $INST_TYPE in
    0)
	get_db_params
	get_admin_console_params
	handle_vhost_params
	get_php_settings
	set_mysql_params
	generate_ui
	generate_api
	setup_batch_server
	setup_dwh
        
	;;
    1)  
        ;;
    2)
        ;;
    3)  
        ;;
    4)
        ;;
    5)
        ;;
    6)
        ;;
esac

#    BIN_DIR
#    CURL_BIN_DIR
#    IMAGE_MAGICK_BIN_DIR
#    LOG_DIR
#    WEB_DIR
