FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y nginx \
vim php7.3 php-mysql php-fpm php-cli php-mbstring mariadb-server \
&& rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default && mkdir /var/www/deddara && touch /var/www/deddara/index.php && echo "<?php phpinfo(); ?>" >> /var/www/deddara/index.php


ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www/deddara
ADD srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www/deddara

RUN chown -R www-data /var/www/* && chmod -R 755 /var/www/*

COPY srcs/wp /etc/nginx/sites-available/
COPY srcs/run_server.sh /var/
COPY srcs/database_creation.sh /var/
COPY srcs/wp-config.php /var/www/deddara/wordpress
COPY srcs/phpmyadmin.inc.php /var/deddara/phpMyAdmin-4.9.5-all-languages

RUN service mysql start



EXPOSE 80

RUN ln -s /etc/nginx/sites-available/wp /etc/nginx/sites-enabled/wordpress
RUN service php7.3-fpm start && service mysql restart

CMD bash /var/run_server.sh