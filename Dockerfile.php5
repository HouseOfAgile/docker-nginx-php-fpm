FROM phusion/baseimage:0.9.18

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

ENV HOME /root

# PHP 5.6
RUN add-apt-repository -y ppa:ondrej/php && \
  apt-get update && apt-get install -y python-software-properties && \
  apt-get update && apt-get install -y \
  nginx \
  software-properties-common \
  git-core \
  php5.6 \
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
  make && \
  chown www-data -R /usr/share/nginx/ && \
  echo "source ~/.bashrc">>/root/.bash_profile && \
  curl -sSL https://raw.github.com/beaudev/bash-profile/master/install-bash-profile.sh|bash && \
  apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN mkdir /etc/service/{01_phpfpm,02_nginx}
ADD build/php5-fpm.sh /etc/service/01_phpfpm/run
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x /etc/service/01_phpfpm/run /etc/service/02_nginx/run

EXPOSE 80

CMD ["/sbin/my_init"]
