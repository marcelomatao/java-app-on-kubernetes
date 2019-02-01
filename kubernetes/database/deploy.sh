#!/bin/bash

docker build -t "antarezdb:0.0.1" .
docker tag antarezdb:0.0.1 marcelomata/antarezdb:0.0.1
docker push marcelomata/antarezdb:0.0.1

# fazer o deploy no kubernetes
kubectl create -f deployment.yaml
kubectl rollout status deployment antarezdb-deployment
kubectl expose deployment antarezdb-deployment --type=NodePort


