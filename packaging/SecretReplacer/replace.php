<?php 
error_reporting(E_ALL); //TODO: remove
include_once(dirname(__FILE__).'/SecretReplacer.class.php');
include_once(dirname(__FILE__).'/ErrorObject.class.php');
include_once(dirname(__FILE__).'/error_codes.php');


// defaults
$default_admin_console_email = 'admin@kaltura.com';
$app_dir = '/opt/kaltura/app/';
$default_admin_partner_id = '-2';
$default_batch_partner_id = '-1';
$default_admin_console_kuser_id = '99999';
$default_template_partner_kuser_id = '36734';




$db_updates = array();
$file_updates = array();

/*
-- 29/07/10 Dor Itzhaki
-- Commented out to replace only secrets and not passwords.

// passwords
$admin_password = 'KalturaPass1';

// admin console system user
InstallUtils::generateSha1Salt($admin_password, $admin_salt, $admin_sha1);	
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE system_user SET salt = '$admin_salt' WHERE email = '$default_admin_console_email'");
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE system_user SET sha1_password = '$admin_sha1' WHERE email = '$default_admin_console_email'");

// admin console kuser (password copied from admin console system user)
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE admin_kuser SET salt = '$admin_salt' WHERE id = '$default_admin_console_kuser_id'");
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE admin_kuser SET sha1_password = '$admin_sha1' where id = '$default_admin_console_kuser_id'");

// template kuser (password copied from admin console system user)
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE admin_kuser SET salt = '$admin_salt' WHERE id = '$default_template_partner_kuser_id'");
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE admin_kuser SET sha1_password = '$admin_sha1' WHERE id = '$default_template_partner_kuser_id'");
*/



// admin console partner
$tmp_secret = InstallUtils::generateSecret();
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE partner SET secret = '$tmp_secret' WHERE  id = '$default_admin_partner_id'");
$tmp_secret = InstallUtils::generateSecret();
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE partner SET admin_secret = '$tmp_secret' WHERE id = '$default_admin_partner_id'");
$file_updates[] = new FileUpdate($app_dir.'/admin_console/configs/application.ini', '/settings.secret(\s)*=(\s)*(.+)/', "settings.secret = $tmp_secret");



// batch partner
$tmp_secret = InstallUtils::generateSecret();
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE partner SET secret = '$tmp_secret' WHERE id = '$default_batch_partner_id'");
$tmp_secret = InstallUtils::generateSecret();
$db_updates[] = new DatabaseUpdate('kaltura', "UPDATE partner SET admin_secret = '$tmp_secret' WHERE id = '$default_batch_partner_id'");
$file_updates[] = new FileUpdate($app_dir.'/batch/batch_config.ini', '/secret(\s)*=(\s)*(.+)/', "secret = $tmp_secret");
$file_updates[] = new FileUpdate($app_dir.'/batch/monitor/fullstatus.php', '/\$secret(\s)*=(\s)*(.+)/', '$secret = \''.$tmp_secret.'\';');

// system pages
$tmp_secret = InstallUtils::generateSecret();
$file_updates[] = new FileUpdate($app_dir.'/alpha/config/kConf.php', '/"system_pages_login_password"(\s)*=>(\s)*(.+),/', "\"system_pages_login_password\" => '$tmp_secret',");

// kmc backdoor
$tmp_secret = InstallUtils::generateSecret();
$file_updates[] = new FileUpdate($app_dir.'/alpha/config/kConf.php', '/"kmc_admin_login_sha1_password"(\s)*=>(\s)*(.+),/', "\"kmc_admin_login_sha1_password\" => '$tmp_secret',");

// don't replace again
$file_updates[] = new FileUpdate($app_dir.'/alpha/config/kConf.php', '/"replace_passwords"(\s)*=>(\s)*(.+),/', "\"replace_passwords\" => false,");


$replacer = new SecretReplacer($db_updates, $file_updates);
$replacer->doWork();

//echo "YOUR ADMIN CONSOLE PASSWORD IS $admin_password".PHP_EOL;
