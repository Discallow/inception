#!/bin/sh
set -e

# Initialize database if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysqld --initialize-insecure --user=mysql
fi

# Start MariaDB in background with Unix socket
mysqld --skip-networking --socket=/var/run/mysqld/mysqld.sock &
PID=$!

# Wait until server is ready (using socket)
until mysqladmin --socket=/var/run/mysqld/mysqld.sock ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 1
done

# Configure root password, database, user
mysql --socket=/var/run/mysqld/mysqld.sock -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# Stop temporary server
mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# Run MariaDB in foreground
exec mysqld --user=mysql
