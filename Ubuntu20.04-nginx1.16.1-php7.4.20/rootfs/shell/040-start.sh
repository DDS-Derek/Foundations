#!/bin/bash

/usr/local/php/sbin/php-fpm -R

/usr/local/nginx/sbin/nginx

exec tail -f /var/log/nginx/error.log;
