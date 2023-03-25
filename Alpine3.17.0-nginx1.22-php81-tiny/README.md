## Basic

/web 容器内web目录

/etc/nginx 容器内nginx配置文件路径

/etc/php81 容器内php配置文件路径

80 默认web端口

```bash
docker pull ddsderek/foundations:Alpine3.17.0-nginx1.22-php81-tiny
```

```bash
docker run -d \
    --name=${name} \
    -e PUID=${user_id} \
    -e PGID=${group_id} \
    -e TZ=Asia/Shanghai \
    -p 80:80 \
    -v /web:/web \
    ddsderek/foundations:Alpine3.17.0-nginx1.22-php81-tiny
```

## ENV 

```bash
[root @ bb9b7a8ae347] in / [d 03:13]
$ nginx -v
nginx version: nginx/1.22.1

[root @ bb9b7a8ae347] in / [d 03:13]
$ php81 -v
PHP 8.1.17 (cli) (built: Mar 21 2023 00:20:02) (NTS)
Copyright (c) The PHP Group
Zend Engine v4.1.17, Copyright (c) Zend Technologies
```

```bash
[root @ bb9b7a8ae347] in / [d 03:13]
$ php -m
[PHP Modules]
Core
date
filter
hash
json
libxml
pcre
readline
Reflection
SPL
standard
zlib

[Zend Modules]

```
