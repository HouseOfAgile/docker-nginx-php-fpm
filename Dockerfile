FROM phusion/baseimage:0.9.18

MAINTAINER Meillaud Jean-Christophe (jc@houseofagile.com)

ENV HOME /root

RUN apt-get update
RUN apt-get -y install python-software-properties
RUN apt-get -y install nginx

RUN apt-get -y install software-properties-common

# PHP > 5.4
RUN add-apt-repository ppa:ondrej/php5-oldstable

RUN apt-get -y install git-core

RUN apt-get -y install php5-fpm php5-mysql php-apc php5-imagick php5-imap php5-mcrypt php5-curl php5-cli php5-gd php5-pgsql php5-sqlite php5-common php-pear curl php5-json php5-intl
RUN apt-get install -y python-software-properties python g++ make

RUN echo "HTML is working with php <?php phpversion('tidy');?> and that's it !" > /usr/share/nginx/html/nginx-container.html

RUN chown www-data -R /usr/share/nginx/

RUN apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN mkdir -p /etc/my_init.d
ADD setup_bash_profile.sh /etc/my_init.d/setup_bash_profile.sh

RUN mkdir           /etc/service/01_phpfpm
ADD build/php5-fpm.sh /etc/service/01_phpfpm/run
RUN chmod +x        /etc/service/01_phpfpm/run

RUN mkdir           /etc/service/02_nginx
ADD build/nginx.sh  /etc/service/02_nginx/run
RUN chmod +x        /etc/service/02_nginx/run

EXPOSE 80

CMD ["/sbin/my_init"]
