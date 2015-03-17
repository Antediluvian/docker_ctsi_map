#!/usr/bin/env bash
all: build

build:
	@docker build --tag=ctsi/postgresql .
	@docker tag -f ctsi/postgresql:9.4 ctsi/postgresql:latest