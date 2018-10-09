FROM phusion/baseimage:0.11

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

# PHP >7
RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 4F4EA0AAE5267A6C && \
  LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
  apt-get update && apt-get install -y software-properties-common && \
  apt-get update && apt-get install -y \
  nginx \
  software-properties-common \
  git-core \
  php7.2 \
  php7.2-fpm \
  php7.2-mysql \
  php7.2-imagick \
  php7.2-imap \
  php7.2-curl \
  php7.2-cli \
  php7.2-gd \
  php7.2-pgsql \
  php7.2-sqlite \
  php7.2-common \
  php-pear \
  curl \
  php7.2-json \
  php7.2-intl \
  php7.2-xml \
  php7.2-mbstring \
  php7.2-zip \
  php-apcu \
  python \
  g++ \
  make \
  sudo && \
  chown www-data -R /usr/share/nginx/ && \
  echo "source ~/.bashrc">>/root/.bash_profile && \
  curl -sSL https://raw.github.com/beaudev/bash-profile/master/install-bash-profile.sh|bash && \
  apt-get clean && rm -rf /tmp/* /var/tmp/* && \
  service php7.2-fpm start

  RUN useradd -d /home/hoauser -ms /bin/bash -g root -G sudo,www-data -p ${DEPL_USER_PASSWORD:-hoauser} hoauser && \
    groupadd hoauser && \
    usermod -aG hoauser hoauser && \
    echo "hoauser ALL=(ALL) NOPASSWD:ALL">/etc/sudoers.d/90-cloud-init-users

# generate a simple index file with phpinfo
ADD nginx-default.conf /etc/nginx/sites-available/default
RUN sed -i 's#%%php_fpm_sock_file%%#/run/php/php7.2-fpm.sock#g' /etc/nginx/sites-available/default && \
  echo "<?php\nphpinfo();">/var/www/html/index.php

# nginx and php-fpm7.2 service
RUN mkdir /etc/service/01_phpfpm /etc/service/02_nginx
RUN echo "#!/usr/bin/env bash\nphp-fpm7.2 -F -c /etc/php/7.2/fpm" > /etc/service/01_phpfpm/run
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x /etc/service/01_phpfpm/run /etc/service/02_nginx/run


EXPOSE 80

CMD ["/sbin/my_init"]
