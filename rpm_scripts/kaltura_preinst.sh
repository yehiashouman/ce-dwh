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

TMPDIR=/tmp/$0_$$

COMMON_RC=`dirname $0`/common.rc
if [ -r $COMMON_RC ];then
    . $COMMON_RC
else
    echo "Couldn't source $COMMON_RC. Aborting."
    exit 1
fi
echo "********PHP Configuration********"

echo "Path to php-cli binary:"
read PHP_CLI
PHP_MAJOR_VERSION=`php -r 'print PHP_MAJOR_VERSION ;'`
PHP_MINOR_VERSION=`php -r 'print PHP_MINOR_VERSION ;'`
if [ $PHP_MAJOR_VERSION -lt 5 ];then
	echo  "ERROR: Kaltura requires php 5.2.x or 5.3.x."
	
elif [ $PHP_MINOR_VERSION -lt 2 ];then
	echo "ERROR: Kaltura requires php 5.2.x or 5.3.x."
else
	echo "OK: PHP version is $PHP_MAJOR_VERSION.$PHP_MINOR_VERSION"
	
fi
$PHP_CLI -m >> "$TMPDIR/php_modules"
for EXT in fileinfo bc calander date filter zlib hash mbstring openssl pcre Gd Curl Memcache Mysql Mysqli Exif ftp iconv json Session spl DOM SimpleXML xml xsl imap ctype ssh2 ;do
    if ! `grep -qi $EXT $TMPDIR/php_modules`;then
	echo "ERROR: PHP extension: $EXT is not loaded."
    fi
done
    

echo "********Apache Configuration********"

echo "Path to apachectl binary:"
read APACHE_CTL
$APACHE_CTL -t -D DUMP_MODULES >"$TMPDIR/apache_modules"
for MODULE in rewrite headers expires filter deflate file_cache env proxy;do
    if ! `grep -qi $MODULE $TMPDIR/apache_modules`;then
	echo "ERROR: Apache module: $MODULE is not loaded."
    fi
done

echo "********MySQL Configuration********"

echo "Path to mysql client binary:"
read MYSQL_BIN
get_db_params()

MYSQL_CONN_STRING="--connect_timeout=5 -h$DB1_HOST -P$MYSQL_PORT-u$DB1_USER"
if [ -n "$DB1_PASS" ];then
    MYSQL_CONN_STRING="$MYSQL_CONN_STRING -p$DB1_PASS"
fi
echo "show databases;" | $MYSQL_BIN $MYSQL_CONN_STRING
if [ $? -ne 0 ];then
    echo "ERROR: Couldn't connect to MySQL, command was: $MYSQL_BIN $MYSQL_CONN_STRING"
fi

echo "********Probing for open listeners********"

echo "memcached port [11211]:"
read MEM_PORT
if [ -z "$MEMD_PORT" ];then 
    MEMD_PORT=11211
fi
echo "Shpinx port [9312]:"
read SPH_PORT
if [ -z "SPH_PORT" ];then 
    SPH_PORT=9312
fi
if ! `netstat -ltu --numeric-ports | grep -q ":$MEMD_PORT"`;then
    echo "WARNING: I couldn't find a listener for memcached on port $MEMD_PORT"
fi
if ! `netstat -ltu --numeric-ports | grep -q ":$SPH_PORT"`;then
    echo "WARNING: I couldn't find a listener for memcached on port $SPH_PORT"
fi
