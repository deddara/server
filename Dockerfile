FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y nginx \
vim php php-common php-gd php-fpm mariadb-server php7.3 php-mysql php-cli php-mbstring \
&& rm /etc/nginx/sites-available/default && rm /etc/nginx/sites-enabled/default

ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www
ADD srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www

COPY srcs/wp /etc/nginx/sites-available/
COPY srcs/run_server.sh /var/
COPY srcs/database_creation.sh /var/

RUN bash /var/database_creation.sh

EXPOSE 80

RUN ln -s /etc/nginx/sites-available/wp /etc/nginx/sites-enabled/wp
RUN service php7.3-fpm start && service mysql restart

CMD bash /var/run_server.sh