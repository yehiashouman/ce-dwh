USE kalturadw;

DROP TABLE IF EXISTS dwh_hourly_errors;

CREATE TABLE dwh_hourly_errors (
	partner_id INT(11) NOT NULL,
	date_id int NOT NULL,
	hour_id int NOT NULL,
	error_object_id VARCHAR(50) NOT NULL,
	error_object_type_id INT(11) NOT NULL,
	error_type_id INT(11) NOT NULL,
	error_sub_type_id INT(11) NOT NULL,
	count_errors INT(11) NOT NULL,
	PRIMARY KEY (`partner_id`,`date_id`,`hour_id`,`error_object_id`, `error_object_type_id`, `error_type_id`, `error_sub_type_id`)
	) ENGINE=INNODB DEFAULT CHARSET=latin1
	/*!50100 PARTITION BY RANGE (date_id)
	(PARTITION p_20101231 VALUES LESS THAN (20110101) ENGINE = INNODB)*/;

CALL add_monthly_partition_for_table('dwh_hourly_errors');