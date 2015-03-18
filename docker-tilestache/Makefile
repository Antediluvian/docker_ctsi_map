#!/usr/bin/env bash

name = ctsi/tilestache
tag  = 1.50.1

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
