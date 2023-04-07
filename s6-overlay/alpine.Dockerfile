FROM alpine:3.17

RUN apk add s6-overlay

ENTRYPOINT [ "/init" ]