USE kalturadw;

DROP TABLE IF EXISTS dwh_dim_flavor_asset_new; 

CREATE TABLE `dwh_dim_flavor_asset_new` (
  `id` VARCHAR(60) NOT NULL DEFAULT '',
  `int_id` INT(11) DEFAULT NULL,
  `partner_id` INT(11) DEFAULT NULL,
  `tags` BLOB,
  `created_at` DATETIME DEFAULT NULL,
  `updated_at` DATETIME DEFAULT NULL,
  `deleted_at` DATETIME DEFAULT NULL,
  `entry_id` VARCHAR(60) DEFAULT NULL,
  `flavor_params_id` INT(11) DEFAULT NULL,
  `status` TINYINT(4) DEFAULT NULL,
  `version` VARCHAR(60) NOT NULL,
  `description` VARCHAR(765) DEFAULT NULL,
  `width` INT(11) DEFAULT NULL,
  `height` INT(11) DEFAULT NULL,
  `bitrate` INT(11) DEFAULT NULL,
  `frame_rate` FLOAT DEFAULT NULL,
  `size` INT(11) DEFAULT NULL,
  `is_original` INT(11) DEFAULT NULL,
  `file_ext_id` INT(11) DEFAULT NULL,
  `container_format_id` INT(11) DEFAULT NULL,
  `video_codec_id` INT(11) DEFAULT NULL,
  `dwh_creation_date` TIMESTAMP NOT NULL DEFAULT '0000-00-00 00:00:00',
  `dwh_update_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ri_ind` TINYINT(4) NOT NULL DEFAULT '0',
  PRIMARY KEY `id` (`id`),
  KEY `deleted_at` (`deleted_at`),
  KEY `dwh_update_date` (`dwh_update_date`)
) ENGINE=MYISAM DEFAULT CHARSET=utf8;

INSERT IGNORE INTO kalturadw.dwh_dim_flavor_asset_new
SELECT 	id, int_id, partner_id, tags, created_at, 
	updated_at, deleted_at, entry_id, flavor_params_id, 
	STATUS, VERSION, description, width, height, 
	bitrate, frame_rate, size, is_original, file_ext_id, 
	container_format_id, video_codec_id, dwh_creation_date, 
	dwh_update_date, ri_ind	 FROM 
	kalturadw.dwh_dim_flavor_asset 
WHERE ri_ind = 0 ORDER BY id, VERSION DESC;

DROP TABLE kalturadw.dwh_dim_flavor_asset;
RENAME TABLE kalturadw.dwh_dim_flavor_asset_new TO kalturadw.dwh_dim_flavor_asset;
