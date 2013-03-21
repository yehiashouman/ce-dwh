USE kalturadw;

DROP TABLE IF EXISTS dwh_fact_errors;

CREATE TABLE dwh_fact_errors (
	file_id INT(11) NOT NULL,
	line_number INT(11) NOT NULL,
	partner_id INT(11) NOT NULL,
	error_time datetime NOT NULL,
	error_date_id int NOT NULL,
	error_hour_id int NOT NULL,
	error_object_id VARCHAR(50) NOT NULL,
	error_object_type_id INT(11) NOT NULL,
	error_code_id INT(11) NOT NULL,
	description mediumtext DEFAULT NULL,
	PRIMARY KEY (`file_id`, `line_number`, `error_date_id`),
	UNIQUE KEY (`error_date_id`,`error_object_id`,`error_object_type_id`,`error_time`)
	) ENGINE=INNODB DEFAULT CHARSET=latin1
	/*!50100 PARTITION BY RANGE (error_date_id)
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
	PARTITION p_20101231 VALUES LESS THAN (20110101) ENGINE = INNODB)*/;
