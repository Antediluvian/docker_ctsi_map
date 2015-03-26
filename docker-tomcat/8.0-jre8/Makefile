#!/usr/bin/env bash

name = hub.sufor.cc/ctsi/tomcat
tag  = 8.0-jre8

all: build

build:
	@docker build --tag=$(name):$(tag) .
	@docker tag -f $(name):$(tag) $(name):latest
