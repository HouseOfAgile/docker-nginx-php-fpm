docker-nginx-php-fpm
=================

[![](https://badge.imagelayers.io/houseofagile/docker-nginx-php-fpm:latest.svg)](https://imagelayers.io/?images=houseofagile/docker-nginx-php-fpm:latest 'Get your own badge on imagelayers.io')


* Simple docker containers for projects based on php
* based on nginx and php-fpm
* support for bash-profile
* Build with docker-apps generator

## Build image

Use build.sh script to generate the various versions.

## pull image from docker hub

Images should be retrieved from docker hub.
## How to launch  a docker instance with nginx and php-fpm

Use either docker compose or Dockerfile to configure your docker instance, here is a simple example :

    FROM houseofagile/docker-nginx-php-fpm:php7.4

    # add your files
    ADD ./config/projects /root/projects
    ADD ./config/ssh-keys /root/ssh-keys
    ADD ./config/sm-config /root/.symfony-manager/sm-config

    EXPOSE 80
    CMD ["/sbin/my_init"]

Build your docker image:

    docker build -t "someorg/someproject:v1" .

You could add some postinstall scripts to customize your image to your need, basically it only provide a base phusion image with php5-fpm and nginx.


