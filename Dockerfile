FROM debian:buster

RUN apt update && apt upgrade -y && apt install -y nginx vim php-fpm

ADD srcs/wordpress-5.4.2-ru_RU.tar.gz /var/www
COPY srcs/run_server.sh /var/

CMD bash /var/run_server.sh