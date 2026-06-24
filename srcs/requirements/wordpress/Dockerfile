FROM debian:bookworm

RUN apt update && apt install -y \
    php-fpm \
    php-mysql \
    php-curl \
    php-mbstring \
    php-xml \
    php-zip \
    php-exif \
    mariadb-client \
    curl

RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
    && chmod +x /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY tools/init.sh /init.sh

RUN chmod +x /init.sh

CMD ["/init.sh"]