all: build

build:
	time docker-compose build;

attach: up shell

up:
	docker-compose up -d

shell:
	docker-compose exec env bash