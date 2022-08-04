#!/bin/sh

# 设置时区
if [ ! -f "/tz.lock" ]; then
 echo -e "\033[34m设置时区... \033[0m"
 sh /shell/010-tz.sh
fi

# 启动nginx
nginx -g "daemon off;"