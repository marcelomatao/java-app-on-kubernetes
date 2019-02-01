#!/bin/bash

./run-tests.sh

( cd database ; ./deploy.sh )

( cd app ; ./deploy.sh )















