#!/bin/bash

VERSION=""

process_arguments() {
    while [ -n "$1" ]
    do
        case $1 in
            -h|--help) echo "It is required to inform the version to the docker image as follows: update.sh -v '0.0.1'"; exit 1;;
            -v) VERSION=$2; shift; break;;
            *) echo "It is required to inform the version to the docker image as follows: update.sh -v '0.0.1'"; exit 1;;
        esac
        echo $1; shift
    done
}

process_arguments "$@"

if [ -z "$VERSION" ]; then
  exit 1;
fi

node_port=$(kubectl get service antarezdb-deployment --output jsonpath='{.spec.ports[*].nodePort}')
sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}:[0-9]\{1,5\}/192.168.99.100:$node_port/g" ../../src/main/resources/application.properties

cd ../.. && mvn clean package -DskipTests && cd kubernetes/app

cp ../../target/spring-boot-sample-hateoas-*.jar ./
docker build -t "antarezapp:"$VERSION .
docker tag antarezapp:$VERSION marcelomata/antarezapp:$VERSION
docker push marcelomata/antarezapp:$VERSION
rm spring-boot-sample-hateoas-*.jar

# fazer o update no kubernetes
kubectl apply -f newversion.yaml --record
kubectl rollout status deployment antarezapp-deployment
