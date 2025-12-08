# using penultimate stable version according to https://www.debian.org/releases/
FROM debian:bookworm

RUN apt-get -y update && \
    apt-get install -y mariadb-server mariadb-client

# Give ownership to 'mysql' user
# This is needed because:
# - MariaDB creates its Unix socket (mysqld.sock) and PID files here at runtime.
# - The directory must exist and be writable by the 'mysql' user, otherwise the server cannot start.
RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

# - '50-server.cnf' is the default MariaDB server configuration file included by Debian/Ubuntu packages.
# - Modifying this file allows overriding default settings (like bind-address, datadir, socket) safely.
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose MariaDB port
EXPOSE 3306

CMD ["/usr/local/bin/entrypoint.sh"]