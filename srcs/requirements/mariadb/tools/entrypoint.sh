#!/bin/sh
set -e

# Initialize database directory if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysqld --initialize-insecure --user=mysql

    mysqld --skip-name-resolve --socket=/var/run/mysqld/mysqld.sock &
    PID=$!

    until mysqladmin --socket=/var/run/mysqld/mysqld.sock ping --silent; do
        sleep 1
    done

    mysql --socket=/var/run/mysqld/mysqld.sock -u root <<EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

exec mysqld --user=mysql --bind-address=0.0.0.0

# Start MariaDB normally
exec mysqld --user=mysql --bind-address=0.0.0.0