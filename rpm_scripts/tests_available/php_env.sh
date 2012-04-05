#!/bin/bash - 
#===============================================================================
#          FILE: php_env.sh
#         USAGE: ./php_env.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Jess Portnoy (), jess.portnoy@kaltura.com
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 04/04/12 19:17:45 EDT
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

echo -e "\n********PHP Configuration********\n"
RC=0
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
for EXT in fileinfo bc calander date filter zlib hash mbstring openssl pcre Gd Curl Memcache Mysql Mysqli Exif ftp iconv json Session spl DOM SimpleXML xml xsl imap ctype ssh2 ;do
    if ! `grep -qi $EXT $TMPDIR/php_modules`;then
	echo -e "${SETCOLOR_FAILURE}ERROR: PHP extension: $EXT is not loaded.$SETCOLOR_NORMAL"
	RC=1
    fi
done

