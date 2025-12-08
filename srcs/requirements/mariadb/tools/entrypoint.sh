#!/bin/sh

# Exit immediately if any command in the script returns a non-zero exit code (i.e., fails).
set -e

# Only initialize the database if it doesn't already exist
if [ ! -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql
    # Start MariaDB in the background to run setup commands
    # --skip-name-resolve avoids DNS lookups
    # --socket sets the Unix socket path
    mysqld --skip-name-resolve --socket=/var/run/mysqld/mysqld.sock &

    # Wait until MariaDB is ready to accept connections
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
# - FLUSH PRIVILEGES makes the changes effective immediately

    # Shut down the temporary background MariaDB process
    mysqladmin --socket=/var/run/mysqld/mysqld.sock -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
fi

# Start MariaDB normally
exec mysqld --user=mysql --bind-address=0.0.0.0
