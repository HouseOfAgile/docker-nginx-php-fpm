docker-nginx-php-fpm
=================

[![](https://badge.imagelayers.io/houseofagile/docker-nginx-php-fpm:latest.svg)](https://imagelayers.io/?images=houseofagile/docker-nginx-php-fpm:latest 'Get your own badge on imagelayers.io')


Simple docker for symfony projects.
Based on nginx and php-fpm 
Support for bash-profile
Support for symfony manager

## Raw usage with php5-fpm
Use the php5-fpm version

    $  docker build -t "houseofagile/docker-nginx-php-fpm:php5" .
    
## Raw usage php7-fpm
Use the php7.0-fpm version

    $  docker build -t "houseofagile/docker-nginx-php-fpm:php7" .

## How to launch  a docker instance with nginx and php-fpm

Use either docker compose or Dockerfile to configure your docker instance, here is a simple example :

    FROM houseofagile/docker-nginx-php-fpm:php5

    MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

    EXPOSE 80
    CMD ["/sbin/my_init"] 
    
Build your docker image:

    docker build -t "someorg/someproject:v1" .

You could add some postinstall scripts to customize your image to your need, basically it only provide a base phusion image with php5-fpm and nginx.

As google told us we need to have ssl everywhere, thanks to letsencrypt we have it. Usually you want to provide SSL within your new docker instance, using [jwilder proxy](https://github.com/jwilder/nginx-proxy) and [jrcs letsencrypt companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion) makes this easy.

### Use it behind [jwilder proxy](https://github.com/jwilder/nginx-proxy) and [jrcs letsencrypt companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion)

    PROJECT_NAME=someproject DOMAIN_NAMES="www.awesomedomain.com,amazingotherdomain.xyz" && docker run -e VIRTUAL_HOST="$DOMAIN_NAMES" -e LETSENCRYPT_HOST="$DOMAIN_NAMES" -e LETSENCRYPT_EMAIL="jc@houseofagile.com" -h $PROJECT_NAME --name $PROJECT_NAME -d -P someorg/someproject:v1
    
You should be able to connect with:

    docker exec -it someproject bash
