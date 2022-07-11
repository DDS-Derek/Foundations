FROM ddsderek/alpine:3.16.0

RUN apk add --no-cache nginx

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/default_server.conf /etc/nginx/conf.d/default_server.conf

RUN addgroup -S www && adduser -S www -G www -h /home/www && \
    mkdir -p /app/web && \
    chown -R www:www /app && \
    chmod -R 755 /app

WORKDIR /app/web

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "daemon off;" ]