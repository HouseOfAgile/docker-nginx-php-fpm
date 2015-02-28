#!/bin/bash
source ~/.bashrc
SM_CONF_DIR=/root/.symfony-manager/sm-config

for file in `ls $SM_CONF_DIR`
do
	source $SM_CONF_DIR/$file
	cat /tmp/default-symfony-nginx.conf | sed "s/__project_name__/$application_projectname/g;s#__project_path__#$application_install_path#g;s/__project_hosts__/$application_host=/g"  > /etc/nginx/sites-available/project_$application_projectname.conf
	ln -s /etc/nginx/sites-available/project_$application_projectname.conf /etc/nginx/sites-enabled/project_$application_projectname.conf
	project_name=${file/sm-config-} 
	#sm_$project_name -fi
done
