FROM alpine:3.17

ENV PUID=1000 \
    PGID=1000 \
    TZ=Asia/Shanghai

RUN apk add --no-cache zip wget tzdata shadow bash nginx && \
    addgroup -S www && adduser -S www -G www -h /app && \
    mkdir -p /app/web && \
    chown -R www:www \
        /app \
        /var/lib/nginx \
        /run/nginx \
        /var/log/nginx && \
    chmod -R 755 /app && \
    rm -rf \
        /var/cache/apk/* \
        /root/.cache \
        /tmp/*

COPY --chmod=755 ./rootfs /

WORKDIR /app/web

EXPOSE 80

ENTRYPOINT [ "/shell/000-start.sh" ]
