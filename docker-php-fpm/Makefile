#!/usr/bin/env bash

name = ctsi/php-fpm
tag  = 5.6.6

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
