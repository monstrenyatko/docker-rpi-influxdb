# InfluxDB for Docker on Raspberry Pi

#### Upstream Links

* Docker Registry @[monstrenyatko/rpi-influxdb](https://hub.docker.com/r/monstrenyatko/rpi-influxdb/)
* GitHub @[monstrenyatko/docker-rpi-influxdb](https://github.com/monstrenyatko/docker-rpi-influxdb)

## About

Rework of the official [image](https://hub.docker.com/r/_/influxdb/) to make it
compatible with Raspberry Pi.

## Build the container

* Execute build script:
```sh
	./build.sh
```

## Run

* Create `Data` storage:
```sh
	INFLUXDB_DATA="influxdb-data"
	docker volume create --name $INFLUXDB_DATA
```
* Create `Configuration` storage:
```sh
	INFLUXDB_CFG="influxdb-config"
	docker volume create --name $INFLUXDB_CFG
```
* Copy `Configuration` to the storage:
```sh
	docker run -v $INFLUXDB_CFG:/mnt --rm -v $(pwd):/src hypriot/armhf-busybox \
		cp /src/influxdb.conf /mnt/influxdb.conf
```
* Edit `Configuration` (OPTIONAL):
```sh
	docker run -v $INFLUXDB_CFG:/mnt --rm -it hypriot/armhf-busybox \
		vi /mnt/influxdb.conf
```
* Start prebuilt image:
```sh
	docker-compose up -d --no-build
```
* Stop/Restart:
```sh
	docker stop influxdb
	docker start influxdb
```