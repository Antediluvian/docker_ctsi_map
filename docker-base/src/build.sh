#! /bin/bash
set -o pipefail

IMAGE=ctsi/centos
VERSION=7.0.1406

docker build -t ${IMAGE}:${VERSION} .
