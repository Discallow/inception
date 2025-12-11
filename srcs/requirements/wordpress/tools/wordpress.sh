#!/bin/sh

# Exit immediately if any command in the script returns a non-zero exit code (i.e., fails).
set -e

if [ ! -f wp-config.php ]; then
# Prepare wp-config.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config-sample.php
	sed -i "s/username_here/$MYSQL_USER/" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/" wp-config-sample.php
	sed -i "/That's all/i define( 'WPLANG', 'en_US' );" wp-config-sample.php
	cp wp-config-sample.php wp-config.php
fi
# Gives PHP-FPM (www-data) full access to WordPress files for writing uploads, themes, plugins
chown -R www-data:www-data /var/www/html

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
		--allow-root
	# To access admin panel: https://your-domain/wp-admin.php
	wp user create $WP_USER $WP_USER_EMAIL \
    --role=subscriber \
    --user_pass=$WP_USER_PASSWORD \
    --allow-root
	# To access admin panel: https://your-domain/wp-login.php
fi

# Start PHP-FPM in the foreground
exec /usr/sbin/php-fpm8.2 -F