FROM alpine:3.17

RUN apk add --no-cache \
        bash \
        tzdata \
        nginx \
        ca-certificates \
        shadow \
        s6-overlay \
    && usermod -s /bin/bash nginx \
    && groupmod -o -g 911 nginx \
    && usermod -o -u 911 nginx \
    && rm -rf /etc/nginx/nginx.conf /etc/nginx/http.d

COPY --chmod=755 ./rootfs /

EXPOSE 80
VOLUME [ "/conf" ]

ENTRYPOINT [ "/init" ]