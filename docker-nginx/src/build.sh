#! /bin/bash
set -o pipefail

IMAGE=ctsi/nginx
VERSION=1.6.0

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest
