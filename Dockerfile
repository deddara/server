FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y nginx vim php php-common php-gd php-fpm mariadb-server php7.3 php-mysql php-cli php-mbstring

ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www
ADD srcs/phpMyAdmin-4.9.5-all-languages.tar.gz /var/www
COPY srcs/run_server.sh /var/

CMD bash /var/run_server.sh