#! /bin/bash
set -o pipefail

IMAGE=ctsi/postgresql
VERSION=9.4

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest
