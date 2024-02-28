COMPOSE = docker-compose
COMPOSE_FILE = docker-compose.yml
DJANGO_CONTAINER = $(shell docker ps -aqf "name=colport-web*")

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: pip-install
pip-install: ## (devcontainer) Install package. Require PKG argument. E.g. make pip-install PKG=django
	pip install $(PKG)
	@make pip-export-requirements

.PHONY: app-start
app-start: ## (devcontainer) Start app for development
	python manage.py runserver 0:8000

.PHONY: app-makemigrations
app-makemigrations: ## (devcontainer) Make migrations
	python manage.py makemigrations

.PHONY: app-migrate
app-migrate: ## (devcontainer) Run migrations
	python manage.py migrate

.PHONY: app-shell
app-shell: ## (devcontainer) Run shell
	python manage.py shell

logs:
	@docker logs -fn 25 ${DJANGO_CONTAINER}

pull:
	@git pull origin $(git rev-parse --abbrev-ref HEAD) --ff-only

cleanimages:
	@docker rmi -f $(shell docker images -f "dangling=true" -q)

down:
	@docker compose down

reload: down prod





