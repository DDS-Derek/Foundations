FROM ddsderek/foundations:Ubuntu20.04

ENV PUID=1000
ENV PGID=1000

ADD ./shell /shell

RUN  apt update -y &&\
     apt-get install -y software-properties-common && \
     add-apt-repository ppa:ondrej/php && \
     apt update -y && \
     apt install -y --no-install-recommends --no-install-suggests nginx supervisor wget \
     php7.4 \
     php7.4-fpm \
     php7.4-zip \
     php7.4-mbstring  \
     php7.4-curl \
     php7.4-bcmath \
     php7.4-xml \
     php7.4-mysql \
     php7.4-xmlrpc \
     php7.4-intl \
     php7.4-imap \
     php7.4-ldap \
     php7.4-sqlite3 \
     php7.4-pgsql \
#     php7.4-dev \
#     php-pear \
#     libz-dev \
     php7.4-gd && \
     mkdir -p  /var/run/php  /run/php  /etc/nginx/cert && \
     ln -sf /dev/stdout /var/log/nginx/access.log  && \
     ln -sf /dev/stderr /var/log/nginx/error.log   && \
     echo "<?php phpinfo(); ?>"  > /var/www/html/index.php && \
     apt remove -y wget && \
     apt clean && \
     rm -rf /var/lib/apt/lists/*   /var/cache/apt && \
     useradd -m -s /sbin/nologin www && \
     chmod -R 755 /shell

ADD ./conf/default /etc/nginx/sites-enabled/default
ADD ./conf/nginx.conf /etc/nginx/nginx.conf
ADD ./conf/size.ini /etc/php/7.4/fpm/conf.d/size.ini
ADD ./conf/supervisord.conf /etc/supervisord.conf
ADD ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

EXPOSE 80/tcp

WORKDIR /app/web