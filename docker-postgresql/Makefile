#!/usr/bin/env bash

name = ctsi/postgis
tag  = 2.1

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
