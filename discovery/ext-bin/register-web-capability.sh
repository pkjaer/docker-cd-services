#!/usr/bin/env bash
echo "Waiting for the Discovery Service to be up and running"
while [ "$(curl --write-out %{http_code} --silent --output /dev/null ${tokenurl})" -ne "200" ]; do sleep 1; done
echo "Discovery Service is up and running" 

echo "Registering Web capability..."
cd /sdl-service/config/
java -jar discovery-registration.jar update
