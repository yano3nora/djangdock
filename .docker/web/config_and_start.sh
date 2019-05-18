#!/bin/sh
sed -i -e "s/DOMAIN/$DOMAIN/g" /etc/nginx/conf.d/default.conf
nginx -g "daemon off;"
