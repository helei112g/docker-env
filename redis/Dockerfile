FROM redis:4.0.14

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV TZ=Asia/Shanghai \
    DATA_DIR=/home/work/app/redis/data \
    CONF_DIR=/home/work/app/redis/conf

# 设置系统时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# 编译文件
RUN groupadd -r work && useradd -r -g work work; \
    mkdir -p $DATA_DIR && mkdir -p $CONF_DIR; \
    chown -R work:work /home

# 拷贝配置文件
COPY conf/redis.conf $CONF_DIR/redis.conf

# 导出端口
EXPOSE 6379
# 启动redis
CMD ["redis-server", "/home/work/app/redis/conf/redis.conf"]
