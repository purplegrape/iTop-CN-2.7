#!/usr/bin/env bash

set -e -x

if [ ! -d /var/www/html ];then
    rsync -aqu /usr/src/web/ /var/www/html/
    mkdir -p /var/www/html/{data,conf,log,env-production,env-production-build}
    chown -R www-data.www-data /var/www/html/{data,conf,log,env-production,env-production-build}
    echo -e "open_basedir=/var/www/html" > /var/www/html/.user.ini
fi

exec -c $@