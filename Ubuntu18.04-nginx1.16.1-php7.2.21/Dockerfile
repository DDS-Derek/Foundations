FROM ubuntu:18.04 AS build-env

ENV NGINX_VERSION 1.16.1
ENV PHP_VERSION 7.2.21
ENV COMPOSER_VERSION 1.9.0

#if not set WORKDIR, each RUN & CMD & ADD & COPY ... need to run `cd /usr/local/src`
WORKDIR /usr/local/src

RUN apt-get update
RUN apt-get install -y wget
RUN apt-get install -y build-essential autoconf make automake bison re2c libxml2-dev libssl-dev libfreetype6-dev libcurl4-gnutls-dev libjpeg-dev libpng-dev libreadline6-dev  pkg-config


#Add user  && download php and nginx source code
#    groupadd -r www && \
#    useradd -M -s /sbin/nologin -r -g www www && /sbin/usermod -u 1000 www && \
# -M, --no-create-home
# -m, --create-home   Create the user's home directory if it does not exist.
# composer install需要
#   Cannot create cache directory /home/www/.composer/cache/repo/https---packagist.org/, or directory is not writable. Proceeding without cache
#   Cannot create cache directory /home/www/.composer/cache/files/, or directory is not writable. Proceeding without cache
# for php pecl install *** autoconf
RUN useradd -m -s /sbin/nologin www
RUN wget -c -O nginx.tar.gz http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
RUN tar -zxf nginx.tar.gz && rm -f nginx.tar.gz && \
     cd nginx-$NGINX_VERSION && \
    ./configure --prefix=/usr/local/nginx \
    --user=www --group=www \
#    --error-log-path=/var/log/nginx/error.log \
#    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --with-pcre \
    --without-mail_pop3_module \
    --without-mail_imap_module \
    --without-mail_smtp_module \
    --with-http_v2_module \
    --with-http_ssl_module \
    --with-http_gzip_static_module \
    --with-http_stub_status_module && \
    make -j4 > /dev/null && make install

RUN wget -c -O php.tar.gz http://php.net/distributions/php-$PHP_VERSION.tar.gz
RUN tar zxf php.tar.gz && rm -f php.tar.gz && \
     cd php-$PHP_VERSION && \
    ./configure --prefix=/usr/local/php \
    --with-config-file-path=/usr/local/php/etc \
    --with-config-file-scan-dir=/usr/local/php/etc/php.d \
    --with-fpm-user=www \
    --with-fpm-group=www \
    --with-mysqli \
    --with-pdo-mysql \
    --with-openssl \
    --with-gd \
    --with-iconv \
    --with-zlib \
    --with-gettext \
    --with-curl \
    --with-png-dir \
    --with-jpeg-dir \
    --with-freetype-dir \
    --enable-fpm \
    --enable-xml \
    --enable-inline-optimization \
    --enable-mbregex \
    --enable-mbstring \
    --enable-mysqlnd \
    --enable-sockets \
    --enable-zip \
    --enable-soap \
    --enable-bcmath \
    --enable-exif \
    --enable-pcntl \
    --disable-cgi \
    --disable-phpdbg \
    && \
    make -j4 > /dev/null && make install;

RUN cp ./php-$PHP_VERSION/php.ini-production /usr/local/php/etc/php.ini && \
    mv /usr/local/php/etc/php-fpm.conf.default /usr/local/php/etc/php-fpm.conf && \
    mv /usr/local/php/etc/php-fpm.d/www.conf.default /usr/local/php/etc/php-fpm.d/www.conf  && \
    strip /usr/local/php/bin/php && \
    strip /usr/local/php/sbin/php-fpm && \
    strip /usr/local/nginx/sbin/nginx
#    --with-xmlrpc \  This extension is EXPERIMENTAL.
#    --with-mhash \
#    --disable-ctype \
#    --enable-shmop \
#    --enable-sysvsem \
#    --enable-ftp \
#   --without-pear    will remove pecl

RUN sed -i 's/^;date\.timezone[ ]*=[ ]*/date\.timezone = Asia\/Shanghai/' /usr/local/php/etc/php.ini  && \
    sed -i 's/^session\.use_strict_mode = 0/session\.use_strict_mode = 1/' /usr/local/php/etc/php.ini  && \
    sed -i 's/^session\.cookie_httponly =$/session\.cookie_httponly = 1/' /usr/local/php/etc/php.ini && \
    sed -i 's/^memory_limit = 128M/memory_limit = 128M/' /usr/local/php/etc/php.ini && \
    sed -i 's/^expose_php = On/expose_php = Off/' /usr/local/php/etc/php.ini && \
    sed -i 's/^upload_max_filesize = 2M/upload_max_filesize = 100M/' /usr/local/php/etc/php.ini && \
    sed -i 's/^listen = 127\.0\.0\.1:9000/listen = \/var\/run\/php-fpm\.sock/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.owner = www/listen.owner = www/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.group = www/listen.group = www/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^;listen.mode = 0660/listen.mode = 0660/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^pm.max_children = 5/pm.max_children = 10/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^pm.max_spare_servers = 3/pm.max_spare_servers = 9/' /usr/local/php/etc/php-fpm.d/www.conf  && \
    sed -i 's/^pm.start_servers = 2/pm.start_servers = 5/' /usr/local/php/etc/php-fpm.d/www.conf
#    sed -i 's/^;cgi\.fix_pathinfo[ ]*=[ ]*1/cgi\.fix_pathinfo=0/' /usr/local/php/etc/php.ini
#    sed -i 's/^;security\.limit_extensions .../default setting is safe/' /usr/local/php/etc/php-fpm.d/www.conf  && \

# phpize need `/usr/local/php/include`
RUN rm -rf /usr/local/php/include
RUN wget -c -O composer https://getcomposer.org/download/${COMPOSER_VERSION}/composer.phar


FROM ddsderek/foundations:Ubuntu18.04

ENV PUID=1000
ENV PGID=1000

COPY --from=build-env /usr/local/nginx /usr/local/nginx
COPY --from=build-env /usr/local/php /usr/local/php
COPY --from=build-env /usr/local/src/composer /usr/local/bin/composer


COPY --from=build-env   \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/libcom_err.so.2 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libcrypt.so.1 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libgcc_s.so.1 \
    /lib/x86_64-linux-gnu/libkeyutils.so.1 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    \
    /lib/x86_64-linux-gnu/

COPY --from=build-env   \
    /usr/lib/x86_64-linux-gnu/libhx509.so.5  \
    /usr/lib/x86_64-linux-gnu/libsqlite3.so.0  \
    /usr/lib/x86_64-linux-gnu/libjpeg.so.8   \
    /usr/lib/x86_64-linux-gnu/libpng16.so.16   \
    /usr/lib/x86_64-linux-gnu/libcurl-gnutls.so.4   \
    /usr/lib/x86_64-linux-gnu/libssl.so.1.1   \
    /usr/lib/x86_64-linux-gnu/libasn1.so.8   \
    /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1   \
    /usr/lib/x86_64-linux-gnu/libgnutls.so.30   \
    /usr/lib/x86_64-linux-gnu/libhcrypto.so.4   \
    /usr/lib/x86_64-linux-gnu/libheimbase.so.1   \
    /usr/lib/x86_64-linux-gnu/libhogweed.so.4   \
    /usr/lib/x86_64-linux-gnu/libidn2.so.0   \
    /usr/lib/x86_64-linux-gnu/libk5crypto.so.3   \
    /usr/lib/x86_64-linux-gnu/liblber-2.4.so.2   \
    /usr/lib/x86_64-linux-gnu/libnettle.so.6   \
    /usr/lib/x86_64-linux-gnu/libroken.so.18   \
    /usr/lib/x86_64-linux-gnu/libstdc++.so.6   \
    /usr/lib/x86_64-linux-gnu/libwind.so.0   \
    /usr/lib/x86_64-linux-gnu/libxml2.so.2   \
    /usr/lib/x86_64-linux-gnu/libfreetype.so.6  \
    /usr/lib/x86_64-linux-gnu/libicuuc.so.60  \
    /usr/lib/x86_64-linux-gnu/libnghttp2.so.14  \
    /usr/lib/x86_64-linux-gnu/librtmp.so.1   \
    /usr/lib/x86_64-linux-gnu/libpsl.so.5   \
    /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2   \
    /usr/lib/x86_64-linux-gnu/libldap_r-2.4.so.2   \
    /usr/lib/x86_64-linux-gnu/libicudata.so.60   \
    /usr/lib/x86_64-linux-gnu/libunistring.so.2   \
    /usr/lib/x86_64-linux-gnu/libgmp.so.10   \
    /usr/lib/x86_64-linux-gnu/libp11-kit.so.0   \
    /usr/lib/x86_64-linux-gnu/libtasn1.so.6   \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.26   \
    /usr/lib/x86_64-linux-gnu/libkrb5support.so.0   \
    /usr/lib/x86_64-linux-gnu/libkrb5.so.3   \
    /usr/lib/x86_64-linux-gnu/libsasl2.so.2   \
    /usr/lib/x86_64-linux-gnu/libgssapi.so.3   \
    /usr/lib/x86_64-linux-gnu/libffi.so.6   \
    /usr/lib/x86_64-linux-gnu/libheimntlm.so.0   \
    \
    /usr/lib/x86_64-linux-gnu/

RUN useradd -m -s /sbin/nologin www && \
    mkdir /var/log/nginx && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /app/web && chown -R www:www /app && \
    ln  -s  /usr/local/php/bin/php    /usr/local/bin/php && \
    ln  -s  /usr/local/php/bin/phpize    /usr/local/bin/phpize && \
    ln  -s  /usr/local/php/bin/pecl    /usr/local/bin/pecl && \
    ln  -s  /usr/local/php/bin/php-config    /usr/local/bin/php-config && \
    ln  -s  /usr/local/nginx/sbin/nginx    /usr/local/sbin/nginx

#overwrite nginx.conf
ADD conf/nginx.conf /usr/local/nginx/conf/nginx.conf
ADD conf/default_server.conf /etc/nginx/conf.d/default_server.conf
ADD conf/php.ini /usr/local/php/etc/php.ini
ADD ./shell /shell

RUN chmod +x /usr/local/bin/composer
# 有了apt-get install 后，从68 MB => 87 MB
RUN apt-get update && apt-get install -y cron ca-certificates && apt-get clean && chmod -R 755 /shell

WORKDIR /app/web

EXPOSE 80
