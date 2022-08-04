#!/bin/sh

groupmod -o -g "$PGID" www
usermod -o -u "$PUID" www