PROJECT_NAME=app

DOCKER_COMPOSE_FILE_BASE=./docker-compose.base.yml
DOCKER_COMPOSE_FILE_DEV=./docker-compose.dev.yml
DOCKER_COMPOSE_FILE_PROD=./docker-compose.prod.yml

FRONT_REPO=https://github.com/Chrono-care/Front.git
BACK_REPO=https://github.com/Chrono-care/Backend.git
PARENT_DIR=../

COMMAND=docker compose -f $(DOCKER_COMPOSE_FILE_BASE) -p $(PROJECT_NAME)

create-network:
	docker network inspect devops-network >/dev/null 2>&1 || docker network create devops-network

start-dev: create-network
	@if [ ! -d "$(PARENT_DIR)Front" ]; then git clone $(FRONT_REPO) $(PARENT_DIR)Front; fi
	@if [ ! -d "$(PARENT_DIR)Backend" ]; then git clone $(BACK_REPO) $(PARENT_DIR)Backend; fi
	$(COMMAND) --env-file .env.dev -f $(DOCKER_COMPOSE_FILE_DEV) up --build -d --force-recreate

start-prod: create-network
	$(COMMAND) --env-file .env.prod -f $(DOCKER_COMPOSE_FILE_PROD) up -d --build

restart: create-network
	$(COMMAND) --env-file .env.dev -f $(DOCKER_COMPOSE_FILE_DEV) restart
	$(COMMAND) --env-file .env.dev -f $(DOCKER_COMPOSE_FILE_PROD) restart

down:
	$(COMMAND) --env-file .env.dev -f $(DOCKER_COMPOSE_FILE_DEV) down
	$(COMMAND) --env-file .env.dev -f $(DOCKER_COMPOSE_FILE_PROD) down

stop:
	docker compose --env-file .env.dev -f docker-compose.base.yml -f docker-compose.dev.yml down
	docker compose --env-file .env.prod -f docker-compose.base.yml -f docker-compose.prod.yml down

logs-dev: create-network
	docker logs -f back-app-dev

logs-prod: create-network
	docker logs -f back-app-prod

start-dev-logs: create-network
	$(MAKE) start-dev && $(MAKE) logs-dev

start-prod-logs: create-network
	$(MAKE) start-prod && $(MAKE) logs-prod

dump-database:
	docker exec -it devops-postgres-dev pg_dump -U chronoadmin --inserts -c --if-exists chronocare > bdd/postgres.sql

drop-dev-database: down
	docker volume rm app_postgres-dev-data

drop-prod-database: down
	docker volume rm app_postgres-prod-data

log-database: 
	docker logs devops-postgres-dev
