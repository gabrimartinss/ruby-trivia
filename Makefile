compose = docker compose

.PHONY: build
build: ##docker build image
	$(compose) build

.PHONY: up
up: ##docker start container
	$(compose) up

.PHONY: stop
stop: ##docker stop containers
	$(compose) stop

.PHONY: logs
logs: ##docker logs containers
	$(compose) logs -f -tail=100

.PHONY: clean
clean: ##docker clean
	$(compose) down --remove-orphans --volumes

.PHONY: console
console: ## open console rails container
	$(compose) run app bundle exec rails console

.PHONY: bash
bash: ## open shell bash in container
	$(compose) run app /bin/bash
