#!/bin/bash

ln -sf /usr/share/zoneinfo/$TZ   /etc/localtime
echo $TZ > /etc/timezone
touch /tz.lock
echo "设置完成" > /tz.lock