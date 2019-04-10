/**
* Set FS_METHOD to direct for lsyncd sync solution
*/
define('FS_METHOD', 'direct');

/**
* Allow for SSL termination by detecting HTTP_X_FORWARDED_PROTO header
*/
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
	$_SERVER['HTTPS'] = 'on';
