#!/usr/bin/env bash

echo "Waiting for the database to be up and running"
while ! nc -w 1 "$dbhost" "$dbport"; do printf '.'; sleep 1; done
echo "The database is up and running" 

/sdl-service/bin/container-start.sh "$startparameters" &
# Manual registration is not needed in Sites 9+
/sdl-service/bin/register-web-capability.sh &

wait