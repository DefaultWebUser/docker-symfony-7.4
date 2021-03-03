#!/bin/bash

PWD=$(pwd);
CPATH="$(PWD=$(pwd); echo $(cd $(dirname "$0"); pwd); cd $PWD)"
NAME="symfony:7.4"
cd $CPATH

docker build . -t $NAME --force-rm --no-cache

cd $PWD
