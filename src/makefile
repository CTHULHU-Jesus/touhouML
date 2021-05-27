# Vars

APP_NAME=touhou-ml

all: recipe.json

recipe.json: app/touhouML/Cargo.toml
	cd app/touhouML/ ;\
	cargo chef prepare
	mv app/touhouML/recipe.json .


build: recipe.json
	docker build -t $(APP_NAME):latest .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(APP_NAME):latest .

run: 
	- docker kill $(APP_NAME)
	- docker rm $(APP_NAME)
	docker run \
		-itd \
		--mount type=bind,source=$(shell pwd)/mountPoint,target=/outside \
		--name="$(APP_NAME)" \
		$(APP_NAME):latest

up: build run

login: 
	docker exec -it $(APP_NAME) /bin/bash

