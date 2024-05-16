all: build

build:
	time docker-compose build;

attach: up shell stop

up:
	docker-compose up -d

shell:
	docker-compose exec dig-container bash

stop:
	docker-compose stop

.PHONY: all build attach up shell stop