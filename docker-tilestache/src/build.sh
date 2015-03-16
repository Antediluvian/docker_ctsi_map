#! /bin/bash
set -o pipefail

IMAGE=ctsi/uwsgi
VERSION=2.0.9

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest

