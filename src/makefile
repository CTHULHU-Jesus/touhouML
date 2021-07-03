# Vars

APP_NAME=touhou-ml

all: recipe.json mountPoint

mountPoint:
	mkdir -p mountPoint

recipe.json: app/touhouML/Cargo.toml
	cd app/touhouML/ ;\
	cargo chef prepare
	mv app/touhouML/recipe.json .

base-build: base.Dockerfile 
	@if [ -f "th06.iso" ]; then \
		docker build -t $(APP_NAME)_base -f ./base.Dockerfile . \
		&& touch base-build; \
	else \
		>&2 echo "Cannot find th06.iso. Please provide a legal unpatched ISO with the game named \"th06.iso\" in this directory. This can be found from moyra shrine website."; \
		false; \
	fi

base-run: mountPoint base-build
	- docker kill $(APP_NAME)_base
	- docker rm $(APP_NAME)_base
	docker run \
		-it \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$$DISPLAY \
		--device /dev/dri \
		--privileged \
		--mount type=bind,source=$(shell pwd)/mountPoint,target=/outside \
		--name="$(APP_NAME)_base" \
		$(APP_NAME)_base
	docker commit $(APP_NAME)_base
	touch base-run


.PHONY: base-up
base-up: base-build base-run

.PHONY: build
build: recipe.json
	docker build -t $(APP_NAME)_full -f full.Dockerfile .


.PHONY: run
run: mountPoint gpu_devices
	- docker kill $(APP_NAME)_full
	- docker rm $(APP_NAME)_full
	docker run \
		-itd \
		--gpus all\
		--privileged \
		--mount type=bind,source=$(shell pwd)/mountPoint,target=/outside \
		--name="$(APP_NAME)_full" \
		$(APP_NAME)_full

.PHONY: up
up: build run

.PHONY: login
login: 
	docker exec -it $(APP_NAME)_full /bin/bash

.PHONY: clean
clean:
	- rm base-*;
	- rm -rf mountPoint
	- rm recipe.json
