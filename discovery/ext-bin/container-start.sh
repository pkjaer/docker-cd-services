#!/usr/bin/env bash

# Java options and system properties to pass to the JVM when starting the service. For example:
# JVM_OPTIONS="-Xrs -Xms128m -Xmx128m -Dmy.system.property=/var/share"
JVM_OPTIONS="-Xrs -Xms128m -Xmx128m"
SERVER_PORT=--server.port=8082

# set max size of request header to 64Kb
MAX_HTTP_HEADER_SIZE=--server.tomcat.max-http-header-size=65536

BASEDIR=$(dirname $0)
CLASS_PATH=.:config:bin:lib/*
CLASS_NAME="com.sdl.delivery.service.ServiceContainer"

ARGUMENTS=()
for ARG in $@
do
    if [[ $ARG == --server\.port=* ]]
    then
        SERVER_PORT=$ARG
    elif [[ $ARG =~ -D.+ ]]; then
    	JVM_OPTIONS=$JVM_OPTIONS" "$ARG
    else
        ARGUMENTS+=($ARG)
    fi
done
ARGUMENTS+=($SERVER_PORT)
ARGUMENTS+=($MAX_HTTP_HEADER_SIZE)

for SERVICE_DIR in `find services -type d`
do
    CLASS_PATH=$SERVICE_DIR:$SERVICE_DIR/*:$CLASS_PATH
done

echo "Starting service in a Docker container..."

java -cp $CLASS_PATH $JVM_OPTIONS $CLASS_NAME ${ARGUMENTS[@]}