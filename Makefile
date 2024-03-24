up:
	docker-compose up -d

down:
	docker-compose down

restart: down up

psql:
	docker exec -it $(shell docker-compose ps -q postgres) psql -U chronocare
