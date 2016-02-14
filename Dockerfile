FROM phusion/baseimage:0.9.18

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

ENV HOME /root

# PHP > 5.6
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4F4EA0AAE5267A6C

RUN add-apt-repository -y ppa:ondrej/php5-5.6
RUN apt-get update && apt-get install -y python-software-properties
RUN apt-get update && apt-get install -y \ 
  python-software-properties \
  nginx \
  software-properties-common \
  git-core \
  php5 \
  php5-fpm \
  php5-mysql \
  php-apc \ 
  php5-imagick \
  php5-imap \
  php5-mcrypt \
  php5-curl \
  php5-cli \
  php5-gd \
  php5-pgsql \
  php5-sqlite \
  php5-common \
  php-pear \
  curl \
  php5-json \
  php5-intl \
  python \ 
  g++ \
  make

RUN chown www-data -R /usr/share/nginx/

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

ADD ./default_bash_profile /root/.bash_profile
RUN curl -sSL https://raw.github.com/beaudev/bash-profile/master/install-bash-profile.sh|bash

RUN mkdir           /etc/service/01_phpfpm
ADD build/php5-fpm.sh /etc/service/01_phpfpm/run
RUN chmod +x        /etc/service/01_phpfpm/run

RUN mkdir           /etc/service/02_nginx
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x        /etc/service/02_nginx/run

EXPOSE 80

CMD ["/sbin/my_init"]
