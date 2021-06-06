# Vars

APP_NAME=touhou-ml

all: recipe.json mountPoint

mountPoint:
	mkdir -p mountPoint

recipe.json: app/touhouML/Cargo.toml
	cd app/touhouML/ ;\
	cargo chef prepare
	mv app/touhouML/recipe.json .

.PHONY: build run up login

build: recipe.json
	@if [ -f "th06.iso" ]; then \
		docker build -t $(APP_NAME):latest . ; \
	else \
		>&2 echo "Cannot find th06.iso. Please provide a legal unpatched ISO with the game named \"th06.iso\" in this directory. This can be found from moyra shrine website."; \
		false; \
	fi

run: mountPoint
	- docker kill $(APP_NAME)
	- docker rm $(APP_NAME)
	docker run \
		-it \
		--privileged \
		--mount type=bind,source=$(shell pwd)/mountPoint,target=/outside \
		--name="$(APP_NAME)" \
		$(APP_NAME):latest


up: build run

login: 
	docker exec -it $(APP_NAME) /bin/bash

screen:
	ip=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' $(APP_NAME)`; \
	echo $$ip; \
	ssh $$ip:6969


	
