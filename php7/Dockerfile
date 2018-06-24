FROM centos:centos7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV PHP_VERSION=7.2.6 \
    TZ=Asia/Shanghai \
    SRC_DIR=/home/work/src \
    APP_DIR=/home/work/app/php

# 设置系统时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 文件拷贝
COPY src/ $SRC_DIR

RUN groupadd -r work && useradd -r -g work work \
    && yum -y install wget gcc gcc++ gcc-c++ make \
      openssl openssl-devel curl-devel libjpeg libjpeg-devel bzip2-devel.x86_64 \
      gmp-devel libxml2 libxml2-devel libxslt-devel libcurl libcurl-devel \
      libpng libpng-devel freetype freetype-devel libedit-devel \
    && cd $SRC_DIR \
    && tar zxvf php-$PHP_VERSION.tar.gz \
    && cd php-$PHP_VERSION \
    && mkdir -p $APP_DIR \
    && BUILD_CONFIG="\
      --prefix=$APP_DIR \
      --datadir=$APP_DIR/data \
      --disable-rpath \
      --enable-shared \
      --enable-xml \
      --enable-bcmath \
      --enable-shmop \
      --enable-sysvsem \
      --enable-mbregex \
      --enable-mbstring \
      --enable-ftp \
      --enable-gd-native-ttf \
      --enable-pcntl \
      --enable-sockets \
      --enable-soap \
      --enable-session \
      --enable-opcache \
      --enable-fpm \
      --with-fpm-user=work \
      --with-fpm-group=work \
      --enable-zip \
      --enable-inline-optimization \
      --enable-gd-jis-conv \
      --enable-mysqlnd \
      --with-config-file-path=$APP_DIR/etc \
      --with-mysql-sock=/var/run/mysql/mysql.sock \
      --with-mcrypt \
      --with-mhash \
      --with-openssl \
      --with-mysqli=shared,mysqlnd \
      --with-pdo-mysql=shared,mysqlnd \
      --with-gd \
      --with-iconv \
      --with-zlib \
      --with-xmlrpc \
      --without-pear \
      --with-gettext \
      --with-curl \
      --with-jpeg-dir \
      --with-freetype-dir \
      --without-gdbm \
      --with-libedit \
      " \
    && ./configure $BUILD_CONFIG \
    && make && make install \
    && rm -rf $SRC_DIR \
    && chown -R work:work /home \
    #&& yum -y remove curl-devel libjpeg libjpeg-devel bzip2-devel.x86_64 \
    #  gmp-devel libxml2 libxml2-devel libxslt-devel libcurl libcurl-devel \
    #  libpng libpng-devel freetype freetype-devel libedit-devel \
    && yum clean all

# 设置环境变量
ENV PATH $APP_DIR/sbin:$APP_DIR/bin:$PATH

# 拷贝配置文件
COPY etc/ /home/work/app/php/etc

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
