#!/bin/sh
set -e

cd /var/www/html

# Fix permissions
chown -R www-data:www-data /var/www/html

# Prepare wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config-sample.php
sed -i "s/username_here/$MYSQL_USER/" wp-config-sample.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config-sample.php
sed -i "s/localhost/$MYSQL_HOSTNAME/" wp-config-sample.php
sed -i "/That's all/i define( 'WPLANG', 'en_US' );" wp-config-sample.php

cp wp-config-sample.php wp-config.php
chown www-data:www-data wp-config.php

# Wait for MariaDB to be available
echo "Waiting for MariaDB TCP port..."
until nc -z "$MYSQL_HOSTNAME" 3306; do
    sleep 1
done
echo "MariaDB is ready!"


# Install WordPress only if not installed
if ! wp core is-installed --allow-root --path=/var/www/html; then
    echo "Running WordPress installation..."
    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root \
        --path=/var/www/html
fi

# Start PHP-FPM
exec /usr/sbin/php-fpm8.2 -F