FROM ubuntu:20.04

ENV TZ=Asia/Shanghai

RUN apt-get update && \
    apt-get install -y zip wget tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY --chmod=755 ./shell /shell

CMD [ "/shell/000-start.sh" ]