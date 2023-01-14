FROM ubuntu:20.04

ENV TZ=Asia/Shanghai \
    PS1="\[\e[32m\][\[\e[m\]\[\e[36m\]\u \[\e[m\]\[\e[37m\]@ \[\e[m\]\[\e[34m\]\h\[\e[m\]\[\e[32m\]]\[\e[m\] \[\e[37;35m\]in\[\e[m\] \[\e[33m\]\w\[\e[m\] \[\e[32m\][\[\e[m\]\[\e[37m\]\d\[\e[m\] \[\e[m\]\[\e[37m\]\t\[\e[m\]\[\e[32m\]]\[\e[m\] \n\[\e[1;31m\]$ \[\e[0m\]"

ADD ./shell /shell

RUN apt-get update && \
    apt-get install -y zip wget tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod -R 755 /shell

CMD [ "/shell/000-start.sh" ]