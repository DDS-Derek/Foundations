FROM alpine:3.18

ENV S6_SERVICES_GRACETIME=30000 \
    S6_KILL_GRACETIME=60000 \
    S6_CMD_WAIT_FOR_SERVICES_MAXTIME=0 \
    S6_SYNC_DISKS=1 \
    LANG=C.UTF-8 \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]" \
    PUID=1000 \
    PGID=1000 

RUN apk add --no-cache \
        bash \
        shadow \
        tzdata \
        s6-overlay \
        nginx \
        php81 \
        php81-fpm \
    && sed -i "s/user = nobody/user = nginx/g" /etc/php81/php-fpm.d/www.conf \
    && sed -i "s/group = nobody/group = nginx/g" /etc/php81/php-fpm.d/www.conf

COPY --chmod=755 ./rootfs /

ENTRYPOINT [ "/init" ]
