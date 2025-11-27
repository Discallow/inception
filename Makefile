all:
	@docker compose --file ./srcs/docker-compose.yml up -d

down:
	@docker compose --file ./srcs/docker-compose.yml down

start:
	@docker compose --file ./srcs/docker-compose.yml start

stop:
	@docker compose --file ./srcs/docker-compose.yml stop
