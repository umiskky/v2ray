FROM alpine:3.13.2 as builder

WORKDIR /opt

RUN wget https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip Xray-linux-64.zip && \
    chmod +x xray

FROM alpine:3.13.2

WORKDIR /opt

COPY docker-entrypoint.sh .
COPY --from=builder /opt/xray /usr/local/bin

RUN apk --no-cache add curl && \
    chmod +x docker-entrypoint.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
