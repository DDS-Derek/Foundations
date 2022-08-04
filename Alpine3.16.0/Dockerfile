FROM alpine:3.16

ENV TZ=Asia/Shanghai

ADD ./shell /shell

RUN apk update && \
    apk add --no-cache zip wget tzdata && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache && \
    rm -rf /tmp/* && \
    chmod -R 755 /shell

CMD [ "/shell/000-start.sh" ]