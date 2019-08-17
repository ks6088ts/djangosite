DOCKER_COMPOSE_YAML := docker-compose.yml
SERVICE := python

# ---

.PHONY: build
build: ## docker-compose build
	docker-compose -f $(DOCKER_COMPOSE_YAML) build $(SERVICE)

.PHONY: up
up: ## docker-compose up
	docker-compose -f $(DOCKER_COMPOSE_YAML) up -d $(SERVICE)

.PHONY: run
run: ## docker-compose run
	docker-compose -f $(DOCKER_COMPOSE_YAML) run --rm $(SERVICE) /bin/sh

.PHONY: login
login: ## login docker container
	docker exec -it $(SERVICE) /bin/sh

.PHONY: clean
clean: ## clean unused docker images
	docker system prune --force
	docker volume prune --force
	docker rm `docker ps -aq` --force
