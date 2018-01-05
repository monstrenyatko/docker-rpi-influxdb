FROM monstrenyatko/rpi-alpine:3.7

MAINTAINER Oleg Kovalenko <monstrenyatko@gmail.com>

ENV LANG en_US.utf8


RUN echo '@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
    apk update && apk upgrade && \
    apk add influxdb@testing tzdata bash su-exec shadow curl && \
    \
# mimic gosu
    ln -s /sbin/su-exec /usr/bin/gosu && \
    \
    mkdir -p /docker-entrypoint-initdb.d && \
    \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/cache/apk/*

COPY influxdb.conf /etc/influxdb/influxdb.conf

COPY run.sh /
RUN chmod +x /run.sh

COPY app-entrypoint.sh /
RUN chmod +x /app-entrypoint.sh

COPY init-influxdb.sh /
RUN chmod +x /init-influxdb.sh

VOLUME ["/var/lib/influxdb"]

EXPOSE 8086

ENTRYPOINT ["/run.sh"]
CMD ["influxdb-app"]
