# docker-hugo
Use this image to build your [Hugo](https://gohugo.io/) website as a docker image.

I use this image as my build container on [gitlab.com](https://gitlab.com) with their built-in CI system.  

## Sample .gitlab-ci.yml
This is the CI configuration I use to build my Hugo based website. I was unable to get the SSH login to work using keys, so it uses ssh-pass to login with userid and password instead.

```
image: mapitman/docker-hugo
stages:
  - build
  - deploy
services:
  - docker:dind
build:
  stage: build
  script:
  - git submodule update --init
  - hugo -t <YOUR_THEME>
  - docker login -u $DOCKER_USER -p $DOCKER_PASS
  - docker build -t $DOCKER_IMAGE_TAG .
  - docker push $DOCKER_IMAGE_TAG
  only:
  - master
deploy:
  stage: deploy
  script:
  - mkdir -p ~/.ssh
  - ssh-keyscan -t rsa $SSH_HOST 2>&1 >> ~/.ssh/known_hosts
  - sshpass -p "$SSH_PASS" ssh $SSH_USER@$SSH_HOST "docker stop blog; docker rm blog; docker pull $DOCKER_IMAGE_TAG:latest && docker run -p 80:80 -p 443:443 -d --name blog $DOCKER_IMAGE_TAG:latest"
  only:
  - master
```
