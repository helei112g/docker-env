FROM centos:centos7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV NGINX_VERSION=1.14.0 \
    ZLIB_VERSION=1.2.11 \
    PCRE_VERSION=8.42 \
    OPENSSL_VERSION=1.0.2o \
    SRC_DIR=/home/work/src \
    WWW_DIR=/home/work/www \
    LOG_DIR=/home/work/logs/nginx

# 拷贝文件
COPY src/ $SRC_DIR

# 下载并编译
RUN groupadd -r work && useradd -r -g work work \
    && yum -y install gcc gcc-c++ make perl \
    && cd $SRC_DIR \
    && tar -zxvf nginx-$NGINX_VERSION.tar.gz \
    && tar -zxvf zlib-$ZLIB_VERSION.tar.gz \
    && tar -zxvf pcre-$PCRE_VERSION.tar.gz \
    && tar -zxvf openssl-$OPENSSL_VERSION.tar.gz \
    && cd nginx-$NGINX_VERSION \
    && BUILD_CONFIG="\
        --prefix=/home/work/app/nginx \
        --user=work \
        --group=work \
        --with-http_stub_status_module \
        --with-http_ssl_module \
        --with-http_v2_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-zlib=$SRC_DIR/zlib-$ZLIB_VERSION \
        --with-openssl=$SRC_DIR/openssl-$OPENSSL_VERSION \
        --with-pcre=$SRC_DIR/pcre-$PCRE_VERSION \
    " \
    && ./configure $BUILD_CONFIG \
    && make && make install \
    && rm -rf /home/work/src \
    && yum -y remove gcc gcc-c++ make perl \
    && yum clean all \
    && mkdir -p $WWW_DIR \
    && mkdir -p $LOG_DIR \
    && chown -R work:work /home

# 设置环境变量
ENV PATH /home/work/app/nginx/sbin:$PATH

# 拷贝配置文件
COPY conf/ /home/work/app/nginx/conf

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8080 443
CMD ["nginx-server"]
