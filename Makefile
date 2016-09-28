NAME = mapitman/docker-hugo
default: build

build:
	docker build -t $(NAME) .

push:
	docker push $(NAME)

run:
	docker run -it --rm $(NAME)
