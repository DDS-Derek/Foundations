#!/bin/bash

# 设置时区
if [ ! -f "/tz.lock" ]; then
 echo -e "\033[34m设置时区... \033[0m"
 bash /shell/010-tz.sh
fi

# 设置PUID PGID
echo -e "\033[34m设置PUID PGID... \033[0m"
sh /shell/011-adduser.sh

# 启动
echo -e "\033[34m启动 \033[0m"
sh /shell/040-start.sh