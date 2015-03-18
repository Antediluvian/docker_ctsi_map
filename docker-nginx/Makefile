#!/usr/bin/env bash

name = ctsi/nginx
tag  = 1.6.2

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
