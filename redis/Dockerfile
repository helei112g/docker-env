FROM centos:centos7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV REDIS_VERSION=3.2.11 \
    SRC_DIR=/home/work/src \
    DATA_DIR=/home/work/data \
    APP_DIR=/home/work/app/redis

COPY src/ $SRC_DIR

# 编译文件
RUN groupadd -r work && useradd -r -g work work \
    && yum -y install gcc gcc-c++ make perl \
    && cd $SRC_DIR \
    && tar xvzf redis-$REDIS_VERSION.tar.gz \
    && cd redis-$REDIS_VERSION \
    && make && make install \
    && yum -y remove gcc gcc-c++ make perl \
    && mkdir -p $DATA_DIR \
    && chown work:work $DATA_DIR \
    && mkdir -p $APP_DIR/conf \
    && cp redis.conf $APP_DIR/conf \
    && rm -rf $SRC_DIR

# 导出端口
EXPOSE 6379

# 启动nginx
CMD ["redis-server", "/home/work/app/redis/etc/redis.conf"]
