FROM openjdk:8-alpine

# Install pre-requisites
RUN apk add --no-cache bash
RUN apk add --no-cache curl

# Copy all the required files
RUN mkdir /sdl-service && chmod 755 /sdl-service
COPY ./standalone /sdl-service
COPY ./ext-bin/* /sdl-service/bin/
COPY ./ext-config/* /sdl-service/config/
COPY ./ext-lib/* /sdl-service/lib/
RUN chmod +x /sdl-service/bin/*.sh

# Set the working directory (for convenience)
WORKDIR /sdl-service

# Start the service (after the database is up)
CMD /bin/bash -C '/sdl-service/bin/container-start-with-dependencies.sh'