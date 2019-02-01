#!/bin/bash

VERSION=""

process_arguments() {
    while [ -n "$1" ]
    do
        case $1 in
            -h|--help) echo "It is required to inform the version to the docker image as follows: update-app.sh -v '0.0.1'"; exit 1;;
            -v) VERSION=$2; shift; break;;
            *) echo "It is required to inform the version to the docker image as follows: update-app.sh -v '0.0.1'"; exit 1;;
        esac
        echo $1; shift
    done
}

process_arguments "$@"

if [ -z "$VERSION" ]; then
  exit 1;
fi

./run-tests.sh

( cd app ; ./update.sh -v $VERSION)















