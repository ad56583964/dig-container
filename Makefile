all: build

build:
	time docker-compose build;

attach: up shell stop

up:
	docker-compose up -d

shell:
	docker-compose exec env bash

stop:
	docker-compose stop