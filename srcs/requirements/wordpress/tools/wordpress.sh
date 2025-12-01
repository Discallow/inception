#!/bin/sh

chown -R www-data:www-data /var/www/html

/usr/sbin/php-fpm8.2 -F