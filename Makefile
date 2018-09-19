NAME = mapitman/docker-hugo
TAG := $(shell git describe --exact-match --tags $(git log -n1 --pretty='%h'))
default: build

build:
	docker build --build-arg VCS_REF=`git rev-parse --short HEAD` --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -t $(NAME):$(TAG) .
		docker tag $(NAME):$(TAG) $(NAME):latest

push:
	docker push $(NAME):$(TAG)
	docker push $(NAME):latest

run:
	docker run -it --rm $(NAME):latest

