#!/bin/bash

MAILUSERS="alex.bandel@kaltura.com,liron.liptz@kaltura.com"

if [ $# -eq 0 ]; then

        echo "No specific date requested, taking today"

        WHEN=$(date +%F)

elif [ $# -eq 1 ]; then

        echo "You requested $1"

        WHEN=$1

else

        echo "Invalid user input"

        exit 1;

fi

 

ETLOGS="/home/etl/logs"

JOBLOG="${ETLOGS}/etl_job-$WHEN.log"

ETLHOME="/home/etl"

for serv_id in `seq 8` ; do

    if [ -s /data/logs/investigate/pa-apache${serv_id}-access_log-$WHEN.gz ] ; then

        echo -e "\n"

        echo "-----------------------------" >>$JOBLOG

        echo "pa-apache${serv_id} is processed" >>$JOBLOG

        echo "-----------------------------" >>$JOBLOG

        zcat /data/logs/investigate/pa-apache${serv_id}-access_log-$WHEN.gz |php /web/kaltura/alpha/scripts/create_event_log_from_apache_access_log.php  2>>$JOBLOG > ${ETLHOME}/events/_events_log_combined_pa-apache${serv_id}-${WHEN}

        mv ${ETLHOME}/events/_events_log_combined_pa-apache${serv_id}-${WHEN} ${ETLHOME}/events/events_log_combined_pa-apache${serv_id}-${WHEN}

   else

        echo -e "\n"

        echo "-----------------------------" >>$JOBLOG

        echo "pa-apache${serv_id} coudnt be  processed" >>$JOBLOG

        echo "-----------------------------" >>$JOBLOG

        echo "pa-apache${serv_id} coudnt be  processed" | mail -s "etljob file pa-apache${serv_id} failed : `date`" ${MAILUSERS}

   fi

done
