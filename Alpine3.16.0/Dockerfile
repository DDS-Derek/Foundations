FROM alpine:3.16

ENV TZ=Asia/Shanghai

ADD ./shell /shell

RUN apk update && \
    echo http://dl-2.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories && \
    apk add --no-cache zip wget tzdata shadow && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache && \
    rm -rf /tmp/* && \
    chmod -R 755 /shell

CMD [ "/shell/000-start.sh" ]