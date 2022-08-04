FROM ddsderek/foundations:Alpine3.16.0

ENV PUID=1000
ENV PGID=1000

RUN apk add --no-cache nginx

ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/default_server.conf /etc/nginx/conf.d/default_server.conf
ADD ./shell /shell

RUN addgroup -S www && adduser -S www -G www -h /home/www && \
    mkdir -p /app/web && \
    chown -R www:www /app && \
    chmod -R 755 /app && \
    chmod -R 755 /shell

WORKDIR /app/web

EXPOSE 80