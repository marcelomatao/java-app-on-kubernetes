#!/bin/bash

docker build -t "antarezdb:0.0.1" .
docker run --rm --network=antarez -d -p 3306:3306 --name "antarezdb" "antarezdb:0.0.1"
