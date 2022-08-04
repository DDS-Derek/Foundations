#!/bin/sh

# 设置时区
if [ ! -f "/tz.lock" ]; then
 echo "\033[34m设置时区... \033[0m"
 sh /shell/010-tz.sh
fi

# 设置PUID PGID
echo "\033[34m设置PUID PGID... \033[0m"
sh /shell/011-adduser.sh

# 启动nginx
echo "\033[34m启动 \033[0m"
exec /usr/bin/supervisord -n -c /etc/supervisord.conf
