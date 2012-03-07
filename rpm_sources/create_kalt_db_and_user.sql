CREATE USER 'kaltura'@'@DB1_HOST@' IDENTIFIED BY '@KALT_PASSWD@';
CREATE DATABASE if not exists kaltura 
CREATE DATABASE if not exists kaltura_sphinx_log 
GRANT ALL PRIVILEGES ON *.kaltura- TO 'kaltura'@'@DB1_HOST@'
GRANT ALL PRIVILEGES ON *.kaltura_sphinx_log- TO 'kaltura'@'@DB1_HOST@'
FLUSH privileges;
COMMIT;
source 01.kaltura_ce_tables.sql
source 02.kaltura_ce_data.sql
source 03.dwh_grants.sql
source 04.stored_procedures.sql
