#!/bin/bash
set -x
source ~/.bash-profile.d/bash-profile
SM_CONF_DIR=/root/.symfony-manager

for file in `ls $SM_CONF_DIR/sm-config`
do
	source $SM_CONF_DIR/sm-config/$file
	cat /tmp/default-symfony-nginx.conf | sed "s/__project_name__/$application_projectname/g;s#__project_path__#$application_install_path#g;s/__project_hosts__/$application_host=/g"  > /etc/nginx/sites-available/project_$application_projectname.conf
	ln -s /etc/nginx/sites-available/project_$application_projectname.conf /etc/nginx/sites-enabled/project_$application_projectname.conf
	project_name=${file/sm-config-} 
#	$SM_CONF_DIR/symfony_manager.sh -l $SM_CONF_DIR/sm-config/$file -fi
	mkdir -p $application_install_path
done
