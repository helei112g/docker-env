FROM centos:centos7

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV REDIS_VERSION=3.2.11 \
    SRC_DIR=/home/work/src \
    DATA_DIR=/home/work/app/redis/data \
    CONF_DIR=/home/work/app/redis/conf

COPY src/ $SRC_DIR

# 编译文件
RUN groupadd -r work && useradd -r -g work work \
    && yum -y install gcc gcc-c++ make perl \
    && cd $SRC_DIR \
    && tar xvzf redis-$REDIS_VERSION.tar.gz \
    && cd redis-$REDIS_VERSION \
    && make && make install \
    && mkdir -p $DATA_DIR \
    && mkdir -p $CONF_DIR \
    && cp redis.conf $CONF_DIR \
    && chown -R work:work /home \
    && yum -y remove gcc gcc-c++ make perl \
    && rm -rf $SRC_DIR

# 导出端口
EXPOSE 6379

# 启动nginx
CMD ["redis-server", "/home/work/app/redis/conf/redis.conf"]
