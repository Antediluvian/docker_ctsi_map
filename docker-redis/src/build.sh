#! /bin/bash
set -o pipefail

IMAGE=ctsi/redis
VERSION=2.8.19

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest
