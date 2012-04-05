#!/bin/bash - 
#===============================================================================
#          FILE: mysql_conn.sh
#         USAGE: ./mysql_conn.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:23:50 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo -e "\n********MySQL Configuration********\n"

MYSQLBIN=`which mysql`
echo "Path to mysql client binary [$MYSQLBIN]:"
read -e MYSQL_BIN
if [ -z "$MYSQL_BIN" -a -x $MYSQLBIN ];then
    MYSQL_BIN=$MYSQLBIN
fi
get_db_params NO_LOG

MYSQL_CONN_STRING="--connect_timeout=5 -h$DB1_HOST -P$DB1_PORT -u$DB1_USER"
if [ -n "$DB1_PASS" ];then
    MYSQL_CONN_STRING="$MYSQL_CONN_STRING -p$DB1_PASS"
fi
echo "show databases;" | $MYSQL_BIN $MYSQL_CONN_STRING
RC=$?
if [ $RC -ne 0 ];then
    echo -e "\n${SETCOLOR_FAILURE}ERROR: Couldn't connect to MySQL, command was: $MYSQL_BIN $MYSQL_CONN_STRING.$SETCOLOR_NORMAL"
else
    echo -e "\n${SETCOLOR_SUCCESS}OK: Connected to $DB1_HOST:$MYSQL_PORT.$SETCOLOR_NORMAL"
fi

