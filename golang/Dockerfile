FROM golang:1.10.3-alpine

# 解释信息
LABEL maintainer="HeLei <dayugog@gmail.com>"

ENV TZ Asia/Shanghai

# 设置系统时区
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
		git \
        vim \
        strace \
        sysstat \
        curl \
	; \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    apk --update add --no-cache perf; \
    go get github.com/astaxie/beego && go get github.com/beego/bee; \
    bee version

EXPOSE 8080

CMD ["bee", "run"]


