#!/usr/bin/env bash

name = ctsi/postgresql
tag  = 9.4

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
