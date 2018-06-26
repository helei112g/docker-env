FROM alpine:3.7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV REDIS_VERSION=3.2.11 \
    TZ=Asia/Shanghai \
    SRC_DIR=/home/work/src \
    DATA_DIR=/home/work/app/redis/data \
    CONF_DIR=/home/work/app/redis/conf

# 设置系统时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY src/ $SRC_DIR

# 编译文件
RUN set -ex; \
    \
    addgroup -S work && adduser -S -G work work; \
    apk add --no-cache --virtual .build-deps \
        coreutils \
        gcc \
        jemalloc-dev \
        linux-headers \
        make \
        musl-dev \
        ; \
    \
    cd $SRC_DIR; \
    tar xvzf redis-$REDIS_VERSION.tar.gz; \
    cd redis-$REDIS_VERSION; \
    make && make install; \
    apk del .build-deps; \
    \
    mkdir -p $DATA_DIR && mkdir -p $CONF_DIR; \
    chown -R work:work /home; \
    rm -rf $SRC_DIR

# 拷贝配置文件
COPY conf/ /home/work/app/redis/conf

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# 导出端口
EXPOSE 6379
# 启动redis
CMD ["redis-server"]
