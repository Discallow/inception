# using penultimate stable version according to https://www.debian.org/releases/
FROM debian:bookworm

# Update package lists, install PHP-FPM and required extensions
RUN apt-get -y update && \
    apt-get install -y php php-fpm php-mysql curl tar

WORKDIR /var/www/html

# Download and extract WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv wordpress/* . && \
    rm -rf wordpress latest.tar.gz

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
COPY ./tools/wp-config.php ./wp-config.php
COPY ./tools/wordpress.sh .
RUN chmod +x ./wordpress.sh
# Expose FastCGI port (used by NGINX)
EXPOSE 9000

# Start PHP-FPM in the foreground
CMD ["./wordpress.sh"]