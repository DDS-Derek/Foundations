FROM php:7.4-apache

RUN apt-get update && \
    # bcmath, calendar, exif, gettext, sockets, dba, mysqli, pcntl, pdo_mysql, shmop, sysvmsg, sysvsem, sysvshm 安装
    docker-php-ext-install -j$(nproc) \
    bcmath \
    calendar \
    exif \
    gettext \
    sockets \
    dba \
    mysqli \
    pcntl \
    pdo_mysql \
    shmop \
    sysvmsg \
    sysvsem \
    sysvshm \
    iconv && \
    # GD安装
    apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd && \
    # yaf安装
    pecl install yaf-3.0.8 && \
    docker-php-ext-enable yaf && \
    # xdebug安装
    pecl install xdebug-2.7.2 && docker-php-ext-enable xdebug && \
    # redis 安装
    pecl install redis-5.0.0 && docker-php-ext-enable redis && \
    # zip 安装
    apt-get install -y zlib1g-dev && apt-get install -y libzip-dev && \
    docker-php-ext-install zip && \
    # apache2 设置
    a2enmod proxy proxy_ajp proxy_http rewrite deflate headers proxy_balancer proxy_connect proxy_html substitute expires vhost_alias && \
    # 清理
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

ADD conf/new.ini /usr/local/etc/php/conf.d/new.ini
ADD conf/apache2.conf /etc/apache2/apache2.conf

EXPOSE 80