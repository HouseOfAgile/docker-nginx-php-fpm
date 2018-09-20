FROM phusion/baseimage:0.11

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

# PHP 5.6
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4F4EA0AAE5267A6C && \
  LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
  apt-get update && apt-get install -y python-software-properties && \
  apt-get update && apt-get install -y \
  nginx \
  software-properties-common \
  git-core \
  php5.6 \
  php5.6-fpm \
  php5.6-mysql \
  php5.6-imagick \
  php5.6-imap \
  php5.6-mcrypt \
  php5.6-curl \
  php5.6-cli \
  php5.6-gd \
  php5.6-pgsql \
  php5.6-sqlite \
  php5.6-common \
  php-pear \
  curl \
  php5.6-json \
  php5.6-intl \
  python \
  g++ \
  make \
  sudo && \
  chown www-data -R /usr/share/nginx/ && \
  echo "source ~/.bashrc">>/root/.bash_profile && \
  curl -sSL https://raw.github.com/beaudev/bash-profile/master/install-bash-profile.sh|bash && \
  apt-get clean && rm -rf /tmp/* /var/tmp/* && \
  service php5.6-fpm start

RUN useradd -d /home/hoauser -ms /bin/bash -g root -G sudo,www-data -p hoauser ${DEPL_USER_PASSWORD:-hoauser} && \
  echo "hoauser ALL=(ALL) NOPASSWD:ALL">/etc/sudoers.d/90-cloud-init-users
# generate a simple index file with phpinfo
ADD nginx-default.conf /etc/nginx/sites-available/default
RUN sed -i 's#%%php_fpm_sock_file%%#/var/run/php/php5.6-fpm.sock#g' /etc/nginx/sites-available/default && \
  echo "<?php\nphpinfo();\n" >/var/www/html/index.php

# nginx and php-fpm5.6 service
RUN mkdir /etc/service/01_phpfpm /etc/service/02_nginx
RUN echo "#!/usr/bin/env bash\nphp-fpm5.6 -F -c /etc/php5/fpm" > /etc/service/01_phpfpm/run
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x /etc/service/01_phpfpm/run /etc/service/02_nginx/run

EXPOSE 80

CMD ["/sbin/my_init"]
