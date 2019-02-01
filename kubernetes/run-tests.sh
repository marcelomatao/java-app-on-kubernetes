#!/bin/bash

docker rm -f $(docker ps -aqf "name=antarezdb")
docker network rm antarez 

docker network create antarez

( cd database ; ./run.sh )

sleep 5

db_ip=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' antarezdb)
sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}/$db_ip:3306/g" ../src/main/resources/application.properties

cd .. && mvn clean test && cd kubernetes

docker rm -f $(docker ps -aqf "name=antarezdb")
docker network rm migration 

















