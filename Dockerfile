FROM phusion/baseimage:0.9.16

MAINTAINER Meillaud Jean-Christophe (jc.meillaud@gmail.com)

ENV HOME /root

RUN apt-get update
RUN apt-get -y install python-software-properties
RUN apt-get -y install nginx

RUN mkdir /srv/www
RUN echo "HTML is working with php <?php phpversion('tidy');?> and that's it !" > /srv/www/default/nginx-container.html

RUN apt-get -y install software-properties-common

# PHP > 5.4
RUN add-apt-repository ppa:ondrej/php5-oldstable
#Node install
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update

RUN apt-get -y install git-core

RUN apt-get -y install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl php5-cli php5-gd php5-pgsql php5-sqlite php5-common php-pear curl php5-json php5-intl
RUN apt-get install -y python-software-properties python g++ make

RUN apt-get install -y nodejs
RUN npm install less -g
RUN npm install -g bower

RUN apt-get install -y redis-server memcached php5-memcache

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/
RUN mv /usr/bin/composer.phar /usr/bin/composer

ADD ./default_bash_profile /root/.bash_profile
RUN curl -sSL https://raw.github.com/beaudev/bash-profile/master/install-bash-profile.sh|bash

ADD ./config/projects /usr/share/nginx/
RUN chown www-data -R /usr/share/nginx/

## Install SSH for a specific user (thanks to public key)
ADD ./private/id_rsa.pub /tmp/your_key
RUN cat /tmp/your_key >> /root/.ssh/authorized_keys && rm -f /tmp/your_key

# Add private key in order to get access to private repo
ADD ./private/id_rsa /root/.ssh/id_rsa

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

ADD ./config/sm-config /root/.symfony-manager/sm-config
ADD ./default-symfony-nginx.conf /tmp/default-symfony-nginx.conf

RUN mkdir -p /etc/my_init.d
ADD setup-projects.sh /etc/my_init.d/setup-projects.sh

RUN mkdir           /etc/service/01_phpfpm
ADD build/php5-fpm.sh /etc/service/01_phpfpm/run
RUN chmod +x        /etc/service/01_phpfpm/run

RUN mkdir           /etc/service/02_nginx
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x        /etc/service/02_nginx/run

EXPOSE 80

CMD ["/sbin/my_init"]
