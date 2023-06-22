FROM alpine:3.18

RUN apk add s6-overlay

ENTRYPOINT [ "/init" ]