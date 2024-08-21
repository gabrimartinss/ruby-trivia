compose = docker compose
compose_dev = $(compose) -f docker-compose.development.yml
compose_prod = $(compose) -f docker-compose.production.yml

.PHONY: build
build: ## docker build image
	$(compose_dev) build

.PHONY: up
up: ## docker start container in development
	$(compose_dev) up

.PHONY: up-prod
up-prod: ## docker start container in production
	$(compose_prod) up

.PHONY: stop
stop: ## docker stop containers
	$(compose_dev) stop

.PHONY: logs
logs: ## docker logs containers
	$(compose_dev) logs -f -tail=100

.PHONY: clean
clean: ## docker clean
	$(compose_dev) down --remove-orphans --volumes

.PHONY: console
console: ## open console rails container
	$(compose_dev) run app bundle exec rails console

.PHONY: bash
bash: ## open shell bash in container
	$(compose_dev) run app /bin/bash
