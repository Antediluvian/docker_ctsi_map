#!/usr/bin/env bash

name = ctsi/centos
tag  = 20150318

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
