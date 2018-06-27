FROM centos:centos7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV PHP_VERSION=7.2.6 \
    TZ=Asia/Shanghai \
    SRC_DIR=/home/work/src \
    APP_DIR=/home/work/app \
    WWW_DIR=/home/work/www

# 设置系统时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 文件拷贝
COPY src/ $SRC_DIR

RUN groupadd -r work && useradd -r -g work work \
    && yum -y install wget gcc gcc++ gcc-c++ make git vim strace \
      openssl openssl-devel curl-devel libjpeg libjpeg-devel bzip2-devel.x86_64 \
      gmp-devel libxml2 libxml2-devel libxslt-devel libcurl libcurl-devel \
      libpng libpng-devel freetype freetype-devel libedit-devel autoconf systemtap-sdt-devel \
    && cd $SRC_DIR \
    && tar zxvf php-$PHP_VERSION.tar.gz \
    && cd php-$PHP_VERSION \
    && mkdir -p $APP_DIR/php \
    && BUILD_CONFIG="\
      --prefix=$APP_DIR/php \
      --datadir=$APP_DIR/php/data \
      --disable-rpath \
      --enable-dtrace \
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
      --with-config-file-path=$APP_DIR/php/etc \
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
    && cd $APP_DIR \
    && git clone https://github.com/phalcon/phalcon-devtools.git \
    && cd phalcon-devtools \
    && ln -s $(pwd)/phalcon.php /usr/bin/phalcon \
    && chmod ugo+x /usr/bin/phalcon \
    #&& yum -y remove wget gcc gcc++ gcc-c++ make git \
      #openssl openssl-devel curl-devel libjpeg libjpeg-devel bzip2-devel.x86_64 \
      #gmp-devel libxml2 libxml2-devel libxslt-devel libcurl libcurl-devel \
      #libpng libpng-devel freetype freetype-devel libedit-devel autoconf \
    && yum clean all \
    && rm -rf $SRC_DIR \
    && mkdir -p $WWW_DIR \
    && chown -R work:work /home

# 设置环境变量
ENV PATH $APP_DIR/php/sbin:$APP_DIR/php/bin:$PATH

# 拷贝配置文件
COPY etc/ /home/work/app/php/etc

# 拷贝so包
COPY extensions/ /home/work/app/php/lib/php/extensions/no-debug-non-zts-20170718

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 9000
CMD ["php-fpm"]
