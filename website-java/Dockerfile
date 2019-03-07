FROM registry.hub.docker.com/library/tomcat:alpine

# Install pre-requisites
RUN apk add --no-cache bash
RUN apk add --no-cache curl

WORKDIR /usr/local/tomcat

# Remove default web applications
RUN rm -rf webapps/ROOT && rm -rf webapps/examples && rm -rf webapps/docs

# Copy the website files
WORKDIR webapps
COPY ./website ROOT/
COPY ./ext-config/* ROOT/WEB-INF/classes/
COPY ./ext-lib/* ROOT/WEB-INF/lib/

# Start the website
CMD /bin/bash -C catalina.sh run