# using penultimate stable version according to https://www.debian.org/releases/
FROM debian:bookworm

RUN apt-get -y update && \
    apt-get install -y mariadb-server mariadb-client

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld


COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 3306

CMD ["/usr/local/bin/entrypoint.sh"]