FROM debian:buster

#simple installing
RUN apt update && apt upgrade -y && apt install -y nginx \
vim php7.3-fpm php7.3-common php7.3-mysql php7.3-gmp php7.3-curl php7.3-intl php7.3-mbstring php7.3-xmlrpc php7.3-gd php7.3-xml php7.3-cli php7.3-zip php7.3-soap php7.3-imap mariadb-server \
&& rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default && \
mkdir /var/www/deddara

#making ssl-sertificate
RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/deddara.pem -keyout /etc/nginx/ssl/deddara.key -subj "/C=RU/ST=Kazan/L=Kazan/O=21 School/OU=deddara/CN=deddara"


#adding phpmyadmin & wordpress
RUN chown -R www-data /var/www/* && chmod -R 755 /var/www/*
ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www/deddara
ADD srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www/deddara
RUN mv /var/www/deddara/phpMyAdmin-4.9.5-all-languages /var/www/deddara/phpmyadmin
COPY srcs/wp-config.php /var/www/deddara/wordpress
COPY srcs/config.inc.php /var/www/deddara/phpmyadmin
RUN rm /var/www/deddara/phpmyadmin/config.sample.inc.php

#nginx configure
COPY srcs/wp_nginx /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/wp_nginx /etc/nginx/sites-enabled/wp_nginx


#database creation
COPY srcs/database_creation.sh /var/
RUN bash /var/database_creation.sh

EXPOSE 80 443

#server starter
COPY srcs/run_server.sh /var/
COPY srcs/autoindexing.sh /var/
CMD bash /var/run_server.sh