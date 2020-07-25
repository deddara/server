# server
### This Dockerfile allows you easily build your server-image.

### Contains:
- Wordpress
- phpMyAdmin
- nginx
- MySQL database

### Description:
After building the image and running docker-container you get server that based on debian:buster image. It allows you to setup your own **Wordpress** site with **phpMyAdmin** control panel and **MySQL** database.

### Instruction:
1. `make build` - will build docker-image
2. `make run` - will run docker-container
3. `make exec` - in case if you want to get into docker-container
4. `make rm` - stop and delete running container with image
