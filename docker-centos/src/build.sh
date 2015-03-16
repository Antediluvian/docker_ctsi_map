#! /bin/bash
set -o pipefail

IMAGE=ctsi/centos
VERSION=20150313

docker build -t ${IMAGE}:${VERSION} .
docker tag -f ${IMAGE}:${VERSION} ${IMAGE}:latest
