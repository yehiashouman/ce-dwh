truncate dwh_hourly_events_country;

INSERT INTO dwh_hourly_events_country
SELECT 	partner_id, 
	date_id, 
    0 hour_id,
	country_id, 
	location_id, 
	sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75
    FROM 
	kalturadw.dwh_aggr_events_country
    WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'country')
    ;
    
truncate dwh_hourly_events_domain;
INSERT INTO dwh_hourly_events_domain 
SELECT 	partner_id, 
	date_id, 
	0 hour_id,
    domain_id, 
	sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75 
	FROM 
	kalturadw.dwh_aggr_events_domain
    WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'domain');
    
    
truncate dwh_hourly_events_entry;
INSERT INTO dwh_hourly_events_entry 
SELECT 	partner_id, 
	date_id, 
	0 hour_id,
    entry_id, 
	sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75	 
	FROM 
	kalturadw.dwh_aggr_events_entry 
     WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'entry')
    ;

truncate dwh_hourly_events_uid;    
INSERT INTO dwh_hourly_events_uid 
SELECT 	partner_id, 
	date_id, 
	0 hour_id,
    kuser_id, 
	sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75	 
	FROM 
	kalturadw.dwh_aggr_events_uid
  WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'uid')
    ;
    
truncate dwh_hourly_events_widget;
INSERT INTO dwh_hourly_events_widget 
SELECT 	partner_id, 
	date_id, 
    0 hour_id,
	widget_id, 
	sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_widget_loads, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75	 
	FROM 
	kalturadw.dwh_aggr_events_widget
   WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'widget')
    ;
    
truncate dwh_hourly_partner;
INSERT INTO dwh_hourly_partner 
SELECT 	partner_id, 
	date_id, 
	0 hour_id,
    sum_time_viewed, 
	count_time_viewed, 
	count_plays, 
	count_loads, 
	count_plays_25, 
	count_plays_50, 
	count_plays_75, 
	count_plays_100, 
	count_edit, 
	count_viral, 
	count_download, 
	count_report, 
	count_media, 
	count_video, 
	count_image, 
	count_audio, 
	count_mix, 
	count_mix_non_empty, 
	count_playlist, 
	count_bandwidth, 
	count_storage, 
	count_users, 
	count_widgets, 
	flag_active_site, 
	flag_active_publisher, 
	aggr_storage, 
	aggr_bandwidth, 
	count_buf_start, 
	count_buf_end, 
	count_open_full_screen, 
	count_close_full_screen, 
	count_replay, 
	count_seek, 
	count_open_upload, 
	count_save_publish, 
	count_close_editor, 
	count_pre_bumper_played, 
	count_post_bumper_played, 
	count_bumper_clicked, 
	count_preroll_started, 
	count_midroll_started, 
	count_postroll_started, 
	count_overlay_started, 
	count_preroll_clicked, 
	count_midroll_clicked, 
	count_postroll_clicked, 
	count_overlay_clicked, 
	count_preroll_25, 
	count_preroll_50, 
	count_preroll_75, 
	count_midroll_25, 
	count_midroll_50, 
	count_midroll_75, 
	count_postroll_25, 
	count_postroll_50, 
	count_postroll_75, 
	count_streaming, 
	aggr_streaming
	FROM 
	kalturadw.dwh_aggr_partner 
    WHERE 
    date_id IN (SELECT DISTINCT aggr_day_int FROM kalturadw.aggr_managment 
    WHERE is_calculated = 1
    AND aggr_name = 'partner')
    ;   