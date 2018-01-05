# InfluxDB Docker image for Raspberry Pi
========================================

[![Build Status](https://travis-ci.org/monstrenyatko/docker-rpi-influxdb.svg?branch=master)](https://travis-ci.org/monstrenyatko/docker-rpi-influxdb)


About
=====

[InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/) time series database in the `Docker` container.

Upstream Links
--------------
* Docker Registry @[monstrenyatko/rpi-influxdb](https://hub.docker.com/r/monstrenyatko/rpi-influxdb/)
* GitHub @[monstrenyatko/docker-rpi-influxdb](https://github.com/monstrenyatko/docker-rpi-influxdb)
* Official Docker Registry @[influxdb](https://hub.docker.com/_/influxdb/)


Quick Start
===========

* Pull prebuilt `Docker` image:

	```sh
		docker pull monstrenyatko/rpi-influxdb
	```
* Start prebuilt image:

	```sh
		docker-compose up -d
	```
* Logs:

	```sh
		docker-compose logs
	```
* Stop/Restart:

	```sh
		docker-compose stop
		docker-compose start
	```
* Start `influx` client application:

	```sh
		docker-compose run --rm influxdb influx <parameters>
	```
* Start `influxdb` with additional command-line parameters:

	```sh
		docker-compose run influxdb influxdb-app <parameters>
	```
* Configuration options:

	- Controlling the `UID` and/or `GUI` of the `influxdb` user.
	Set the `INFLUXDB_UID` and/or `INFLUXDB_GID` environment variables.

	- Database initialization script execution:

	```sh
		docker-compose run --rm influxdb influxdb-app db-init
	```
	The script requires `Environment Variables` to be set.
	See [official Docker image](https://hub.docker.com/_/influxdb/) to find all supported official
	`Environment Variables` in `Database Initialization` section.
	Additionally, the `INFLUXDB_ADMIN_PASSWORD_FILE` and `INFLUXDB_USER_PASSWORD_FILE` variables available for
	automatic population of the `INFLUXDB_ADMIN_PASSWORD` and `INFLUXDB_USER_PASSWORD` variables from file.

	- Overriding the main configuration file:

	```yaml
		influxdb:
		  ...
		  volumes:
		    - ./my_custom-influxdb.conf:/etc/influxdb/influxdb.conf:ro
	```

Container is already configured for automatic restart (See `docker-compose.yml`).


Build own image
===============

```sh
	cd <path to sources>
	./build.sh <tag name>
```
