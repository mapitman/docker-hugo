# docker-hugo

Use this image to build your [Hugo](https://gohugo.io/) website as a docker image.

I use this image as my build container on [gitlab.com](https://gitlab.com) with their built-in CI system.  

## Sample .gitlab-ci.yml
This is the CI configuration I use to build my Hugo based website. I sync the contents to an Amazon Web Services S3 bucket. Then I've setup Cloudfront to handle SSL in front of the bucket.

```sh
image: mapitman/hugo:latest
stages:
  - build
  - deploy
variables:
  GIT_SUBMODULE_STRATEGY: recursive
build:
  stage: build
  script:
  - hugo
  artifacts:
    paths:
    - public

deploy:
  stage: deploy
  script:
  - aws s3 sync ./public/ s3://$AWS_S3_BUCKET/ --acl public-read --delete
  - aws cloudfront create-invalidation --distribution-id $AWS_DIST_ID  --paths "/*"
  only:
  - master
```

