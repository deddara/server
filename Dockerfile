FROM debian:buster

#simple installing
RUN apt update && apt upgrade -y && apt install -y nginx \
vim php7.3 php-mysql php-fpm php-cli php-mbstring mariadb-server \
&& rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default && \
mkdir /var/www/deddara && touch /var/www/deddara/index.php && echo "<?php phpinfo(); ?>" >> /var/www/deddara/index.php

#adding phpmyadmin & wordpress
ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www/deddara
ADD srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www/deddara
RUN mv /var/www/deddara/phpMyAdmin-4.9.5-all-languages /var/www/deddara/phpmyadmin
COPY srcs/wp-config.php /var/www/deddara/wordpress
COPY srcs/phpmyadmin.inc.php /var/www/deddara/phpmyadmin
RUN chown -R www-data /var/www/* && chmod -R 755 /var/www/*

#nginx configure
COPY srcs/wp_nginx /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wp_nginx /etc/nginx/sites-enabled/wp_nginx
COPY srcs/run_server.sh /var/


#database creation
COPY srcs/database_creation.sh /var/
RUN bash /var/database_creation.sh

EXPOSE 80

RUN service php7.3-fpm start && service mysql restart

CMD bash /var/run_server.sh