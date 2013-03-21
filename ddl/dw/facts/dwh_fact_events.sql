CREATE TABLE kalturadw.dwh_fact_events
     (
	  file_id INT NOT NULL
	, event_id INT  NOT NULL
	, event_type_id SMALLINT  NOT NULL
	, client_version VARCHAR(31)
	, event_time DATETIME
	, event_date_id INT
	, event_hour_id TINYINT
	, session_id VARCHAR(50)
	, partner_id INT
	, entry_id VARCHAR(20)
	, unique_viewer VARCHAR(40)
	, widget_id VARCHAR(31)
	, ui_conf_id INT
	, uid VARCHAR(64)
	, current_point INT
	, duration INT
	, user_ip VARCHAR(15)
	, user_ip_number INT UNSIGNED
	, country_id INT
	, location_id INT
	, process_duration INT
	, control_id VARCHAR(15)
	, seek INT
	, new_point INT
	, domain_id INT
	, entry_media_type_id INT
	, entry_partner_id INT
	, referrer_id INT(11)
	, os_id INT(11)
	, browser_id INT(11)
	, context_id INT(11) DEFAULT NULL
	, user_id INT(11) DEFAULT NULL
	,application_id INT(11) DEFAULT NULL
	,PRIMARY KEY (file_id,event_id,event_date_id)
	,KEY Entry_id (Entry_id)
	,KEY `event_hour_id_event_date_id_partner_id` (event_hour_id, event_date_id, partner_id)
     ) ENGINE=INNODB  DEFAULT CHARSET=utf8  
/*!50100 PARTITION BY RANGE (event_date_id)
(PARTITION p_20080531 VALUES LESS THAN (20080601) ENGINE = INNODB,
PARTITION p_20080630 VALUES LESS THAN (20080701) ENGINE = INNODB,
PARTITION p_20080731 VALUES LESS THAN (20080801) ENGINE = INNODB,
PARTITION p_20080831 VALUES LESS THAN (20080901) ENGINE = INNODB,
PARTITION p_20080930 VALUES LESS THAN (20081001) ENGINE = INNODB,
PARTITION p_20081031 VALUES LESS THAN (20081101) ENGINE = INNODB,
PARTITION p_20081130 VALUES LESS THAN (20081201) ENGINE = INNODB,
PARTITION p_20081231 VALUES LESS THAN (20090101) ENGINE = INNODB,
PARTITION p_20090131 VALUES LESS THAN (20090201) ENGINE = INNODB,
PARTITION p_20090228 VALUES LESS THAN (20090301) ENGINE = INNODB,
PARTITION p_20090331 VALUES LESS THAN (20090401) ENGINE = INNODB,
PARTITION p_20090430 VALUES LESS THAN (20090501) ENGINE = INNODB,
PARTITION p_20090531 VALUES LESS THAN (20090601) ENGINE = INNODB,
PARTITION p_20090630 VALUES LESS THAN (20090701) ENGINE = INNODB,
PARTITION p_20090731 VALUES LESS THAN (20090801) ENGINE = INNODB,
PARTITION p_20090831 VALUES LESS THAN (20090901) ENGINE = INNODB,
PARTITION p_20090930 VALUES LESS THAN (20091001) ENGINE = INNODB,
PARTITION p_20091031 VALUES LESS THAN (20091101) ENGINE = INNODB,
PARTITION p_20091130 VALUES LESS THAN (20091201) ENGINE = INNODB,
PARTITION p_20091231 VALUES LESS THAN (20100101) ENGINE = INNODB,
PARTITION p_20100131 VALUES LESS THAN (20100201) ENGINE = INNODB,
PARTITION p_20100228 VALUES LESS THAN (20100301) ENGINE = INNODB,
PARTITION p_20100331 VALUES LESS THAN (20100401) ENGINE = INNODB,
PARTITION p_20100430 VALUES LESS THAN (20100501) ENGINE = INNODB,
PARTITION p_20100531 VALUES LESS THAN (20100601) ENGINE = INNODB,
PARTITION p_20100630 VALUES LESS THAN (20100701) ENGINE = INNODB,
PARTITION p_20100731 VALUES LESS THAN (20100801) ENGINE = INNODB,
PARTITION p_20100831 VALUES LESS THAN (20100901) ENGINE = INNODB,
PARTITION p_20100930 VALUES LESS THAN (20101001) ENGINE = INNODB,
PARTITION p_20101031 VALUES LESS THAN (20101101) ENGINE = INNODB,
PARTITION p_20101130 VALUES LESS THAN (20101201) ENGINE = INNODB,
PARTITION p_20101231 VALUES LESS THAN (20110101) ENGINE = INNODB) */;