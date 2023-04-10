FROM docker.io/ubuntu:22.04

RUN apt update -y \
    && DEBIAN_FRONTEND=noninteractive apt install -y git apache2  php8.1 php8.1-mysql php-pear \
        php8.1-gd php8.1-imap php8.1-mbstring php8.1-intl \
    && rm /var/www/html/index.html 

COPY . /install
WORKDIR /install

RUN php manage.php deploy --setup /var/www/html \
    && php manage.php deploy -v /var/www/htdocs/html \
    && cp /var/www/html/include/ost-sampleconfig.php /var/www/html/include/ost-config.php \
    && chmod 0666 /var/www/html/include/ost-config.php \
    && rm -rf /install 

CMD /usr/sbin/apachectl -D FOREGROUND
