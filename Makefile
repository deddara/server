NAME = ft_server
VERSION = latest

.PHONY: build 
build:
	sudo docker build -t $(NAME):$(VERSION) .

.PHONY: run
run:
	sudo docker run -p 80:80 -p 443:443 --name $(NAME) -d $(NAME):$(VERSION)

.PHONY : rm
rm:
	sudo docker stop $(NAME)
	sudo docker rm $(NAME)
	sudo docker rmi $(NAME):$(VERSION)

.PHONY: exec
exec:
	sudo docker exec -it $(NAME) /bin/bash 