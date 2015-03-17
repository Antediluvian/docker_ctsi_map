#!/usr/bin/env bash

name = ctsi/redis
tag  = 2.8.19

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
