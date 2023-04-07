FROM ubuntu:22.04

ENV PATH=${PATH}:/command

COPY --from=shinsenter/s6-overlay / /

ENTRYPOINT ["/init"]

#linux/amd64
#linux/arm/v7
#linux/arm64/v8
#linux/ppc64le
#linux/s390x