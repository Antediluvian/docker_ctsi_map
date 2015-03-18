#!/usr/bin/env bash

name = ctsi/tomcat
tag  = 8.0.20

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
