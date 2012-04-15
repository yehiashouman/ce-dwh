#!/bin/bash - 
#===============================================================================
#          FILE: kaltura_preinst.sh
#         USAGE: ./kaltura_preinst.sh 
#   DESCRIPTION: Will be used by PS to determine whether an ENV is sane prior to installing Kaltura. 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy <jess.portnoy@kaltura.com>
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 03/01/12 12:53:33 IST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

TMPDIR=/tmp/`basename $0`_$$
mkdir -p $TMPDIR

COMMON_RC=`dirname $0`/common.rc
if [ -r $COMMON_RC ];then
    . $COMMON_RC
else
    echo "${SETCOLOR_FAILURE}Couldn't source $COMMON_RC. Aborting.$SETCOLOR_NORMAL"
    exit 1
fi
echo -e "\n********PHP Configuration********\n"

echo "Path to php-cli binary [`which php 2>/dev/null`]:"
read -e PHP_CLI
if [ -z "$PHP_CLI" -a -x `which php 2>/dev/null` ];then
    PHP_CLI=`which php`
fi
PHP_MAJOR_VERSION=`php -r 'print PHP_MAJOR_VERSION ;'`
PHP_MINOR_VERSION=`php -r 'print PHP_MINOR_VERSION ;'`
if [ $PHP_MAJOR_VERSION -lt 5 ];then
	echo  -e "${SETCOLOR_FAILURE}ERROR: Kaltura requires php 5.2.x or 5.3.x.$SETCOLOR_NORMAL"
	
elif [ $PHP_MINOR_VERSION -lt 2 ];then
	echo -e "${SETCOLOR_FAILURE}ERROR: Kaltura requires php 5.2.x or 5.3.x.$SETCOLOR_NORMAL"
else
	echo -e "${SETCOLOR_SUCCESS}OK: PHP version is $PHP_MAJOR_VERSION.$PHP_MINOR_VERSION.${SETCOLOR_NORMAL}"
	
fi
$PHP_CLI -m >> "$TMPDIR/php_modules"
for EXT in fileinfo bc calendar date filter zlib hash mbstring openssl pcre Gd Curl Memcache Mysql Mysqli Exif ftp iconv json Session spl DOM SimpleXML xml xsl imap ctype ssh2 ;do
    if ! `grep -qi $EXT $TMPDIR/php_modules`;then
	echo -e "${SETCOLOR_FAILURE}ERROR: PHP extension: $EXT is not loaded.$SETCOLOR_NORMAL"
    fi
done
    

echo -e "********Apache Configuration********\n"
get_apachectl
$APACHE_CTL -t -D DUMP_MODULES >"$TMPDIR/apache_modules"
for MODULE in rewrite headers expires filter deflate file_cache env proxy;do
    if ! `grep -qi $MODULE $TMPDIR/apache_modules`;then
	echo -e "${SETCOLOR_FAILURE}ERROR: Apache module: $MODULE is not loaded.$SETCOLOR_NORMAL"
    else
	echo -e "${SETCOLOR_SUCCESS}OK: Apache module: $MODULE is loaded.$SETCOLOR_NORMAL"
    fi
done

echo -e "********MySQL Configuration********\n"

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
if [ $? -ne 0 ];then
    echo -e "\n${SETCOLOR_FAILURE}ERROR: Couldn't connect to MySQL, command was: $MYSQL_BIN $MYSQL_CONN_STRING.$SETCOLOR_NORMAL"
else
    echo -e "\n${SETCOLOR_SUCCESS}OK: Connected to $DB1_HOST:$MYSQL_PORT.$SETCOLOR_NORMAL"
fi

echo -e "********Probing for open listeners********\n"

echo "memcached port [11211]:"
read MEM_PORT
if [ -z "$MEMD_PORT" ];then 
    MEMD_PORT=11211
fi
if ! `netstat -ltu --numeric-ports | grep -q ":$MEMD_PORT"`;then
    echo -e "${SETCOLOR_FAILURE}ERROR: I couldn't find a listener for memcached on port $MEMD_PORT.$SETCOLOR_NORMAL"
else
    echo -e "${SETCOLOR_SUCCESS}OK: there's a listener on $MEMD_PORT.$SETCOLOR_NORMAL"
fi
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

for BIN in rsync curl convert wget nmap telnet dig ping java ssh ifconfig emacs mount umount cat head tail less top uptime;do
    echo "Is $BIN executable...?"
    which $BIN
    if [ $? -eq 0 ];then
	echo -e "${SETCOLOR_SUCCESS}OK: $BIN exists and is executable.$SETCOLOR_NORMAL"
    else
	echo -e "${SETCOLOR_FAILURE}ERROR: I couldn't find $BIN.$SETCOLOR_NORMAL"
    fi
done
rm -rf $TMPDIR
