#!/bin/bash

/usr/local/php/sbin/php-fpm -R

/usr/local/nginx/sbin/nginx

tail -f /var/log/nginx/error.log;
