#! /bin/bash
set -o pipefail

IMAGE=ctsi/tilestache
VERSION=1.50.1

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest
