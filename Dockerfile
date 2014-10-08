FROM debian:jessie
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y install wget && \
    wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb -O /tmp/influx.deb && \
    dpkg -i /tmp/influx.deb && apt-get -f -y install && rm /tmp/influx.deb
COPY config.toml /influxdb/config.toml
EXPOSE 8083 8086 8090
WORKDIR /opt/influxdb/current
VOLUME /influxdb/db /influxdb/wal
ENTRYPOINT ["influxdb"]
CMD ["-config", "/influxdb/config.toml"]
