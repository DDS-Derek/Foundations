#!/bin/bash

/usr/local/php/sbin/php-fpm

/usr/local/nginx/sbin/nginx

tail -f /var/log/nginx/error.log;