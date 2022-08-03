FROM ubuntu:18.04

ENV TZ=Asia/Shanghai

ADD ./shell /shell

RUN apt-get update && \
    apt-get install -y zip wget tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod -R 755 /shell

CMD [ "/shell/000-start.sh" ]