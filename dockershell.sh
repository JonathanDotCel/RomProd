#!/bin/sh

ROOT=$(dirname $0)
CWD=$(pwd)
cd $ROOT
ROOT=$(pwd)
cd $CWD

docker pull unirom/build:latest
docker run --rm -t -i -w/project${CWD#$ROOT} -v "${ROOT}:/project" -u `id -u`:`id -g` unirom/build:latest bash -l
