FROM resin/rpi-raspbian:jessie

MAINTAINER Oleg Kovalenko <monstrenyatko@gmail.com>

RUN set -x && \
	apt-get update && apt-get install -y curl apt-transport-https && \
	curl -sL https://repos.influxdata.com/influxdb.key | apt-key add - && \
	echo "deb https://repos.influxdata.com/debian jessie stable" > /etc/apt/sources.list.d/influxdb.list && \
	apt-get update && apt-get install -y influxdb && \
	apt-get purge -y curl apt-transport-https && \
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

EXPOSE 8086

VOLUME ["/config", "/data"]

CMD ["influxd", "-config", "/config/influxdb.conf"]
