<?php
// Database settings from environment variables
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQL_USER'));
define('DB_PASSWORD', getenv('MYSQL_PASSWORD'));
define('DB_HOST', getenv('MYSQL_HOSTNAME') . ':3306');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Authentication keys and salts (you can generate them at https://api.wordpress.org/secret-key/1.1/salt/)
define('AUTH_KEY',         'put-your-unique-phrase-here');
define('SECURE_AUTH_KEY',  'put-your-unique-phrase-here');
define('LOGGED_IN_KEY',    'put-your-unique-phrase-here');
define('NONCE_KEY',        'put-your-unique-phrase-here');
define('AUTH_SALT',        'put-your-unique-phrase-here');
define('SECURE_AUTH_SALT', 'put-your-unique-phrase-here');
define('LOGGED_IN_SALT',   'put-your-unique-phrase-here');
define('NONCE_SALT',       'put-your-unique-phrase-here');

// Debug

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);       // Log errors to wp-content/debug.log
define('WP_DEBUG_DISPLAY', false); 

/* $test = new wpdb(
    getenv('MYSQL_USER'),
    getenv('MYSQL_PASSWORD'),
    getenv('MYSQL_DATABASE'),
    getenv('MYSQL_HOSTNAME') . ':3306'
);

if ($test->dbh === false) {
    die("WORDPRESS MYSQL ERROR: " . $test->last_error);
} */

// WordPress database table prefix
$table_prefix = 'wp_';

// Absolute path to WordPress
if ( !defined('ABSPATH') ) {
    define('ABSPATH', dirname(__FILE__) . '/');
}

// Sets up WordPress vars and included files
require_once(ABSPATH . 'wp-settings.php');
