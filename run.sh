#!/bin/bash

# Usage: file_env_opt VAR [DEFAULT]
file_env_opt() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ -z "${!var:-}" ] && [ -z "${!fileVar:-}" ] && [ -z "${def:-}" ]; then
		return 0
	fi
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

# Debug output
set -x

# Exit on error
set -e

if [ -n "$INFLUXDB_GID" ]; then
	groupmod --gid $INFLUXDB_GID influxdb
	usermod --gid $INFLUXDB_GID influxdb
fi

if [ -n "$INFLUXDB_UID" ]; then
	usermod --uid $INFLUXDB_UID influxdb
fi

if [ "$1" = 'influxdb-app' ]; then
	shift;
	set +x
	file_env_opt 'INFLUXDB_ADMIN_PASSWORD'
	file_env_opt 'INFLUXDB_USER_PASSWORD'
	set -x
	chmod +rX -R /etc/influxdb
	mkdir -p /var/lib/influxdb
	chown -R influxdb:influxdb /var/lib/influxdb
	export APP_USERNAME=influxdb
	if [ "$1" = 'db-init' ]; then
		shift;
		exec /app-entrypoint.sh /init-influxdb.sh "$@"
	else
		exec /app-entrypoint.sh influxd "$@"
	fi
fi

exec "$@"
