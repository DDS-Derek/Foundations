#!/bin/sh

groupmod -o -g "$PGID" www-data
usermod -o -u "$PUID" www-data