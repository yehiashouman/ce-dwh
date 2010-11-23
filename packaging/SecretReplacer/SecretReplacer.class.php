<?php

include_once(dirname(__FILE__).'/DatabaseUtils.class.php');
include_once(dirname(__FILE__).'/InstallUtils.class.php');


class SecretReplacer
{

	private $database_updates;
	
	private $file_updates;
	
	public function __construct($db_updates, $file_updates)
	{
		$this->database_updates = $db_updates;
		$this->file_updates = $file_updates;
	}


	public function doWork()
	{
		foreach ($this->database_updates as $db_up) {
			$this->updateDb($db_up);
		}
		foreach ($this->file_updates as $file_up) {
			$this->updateFile($file_up);
		}
	}
	
	
	private function updateDb(DatabaseUpdate $db_up)
	{
		$result = DatabaseUtils::executeQuery($db_up->query, '127.0.0.1', 'root', 'root', $db_up->database, '3306');
		if ($result !== true) {
			var_dump($result);
		}
	}
	
	
	private function updateFile(FileUpdate $file_up)
	{
		$data = @file_get_contents($file_up->file_path);
		if (!$data) {
			var_dump(InstallUtils::getLastError());
		}
		else {
	
			$data = preg_replace($file_up->regexp, $file_up->replace ,$data);

			if (!@file_put_contents($file_up->file_path, $data)) {
				var_dump(InstallUtils::getLastError());
			}
		}
	}
	
	
}



/**
 * Database updates
 */
class DatabaseUpdate
{
	public $database;
	public $query;

	
	public function __construct($database, $query)
	{
		$this->database = $database;
		$this->query = $query;
	}
}


/**
 * File updates
 */
class FileUpdate
{
	public $file_path;
	public $regexp;
	public $replace;
	
	public function __construct($path, $regexp, $replace)
	{
		$this->file_path = $path;
		$this->regexp = $regexp;
		$this->replace = $replace;		
	}
}