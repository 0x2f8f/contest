##################
# Variables
##################

DOCKER_COMPOSE = docker-compose -f ./docker/docker-compose.yml
DOCKER_COMPOSE_PHP_FPM_EXEC = ${DOCKER_COMPOSE} exec -u www-data php-fpm

##################
# Docker compose
##################

build:
	mkdir -p ./sources/api/public && ( [ -e ./sources/api/public/index.php ] || (touch ./sources/api/public/index.php && echo "api">./sources/api/public/index.php))
	mkdir -p ./sources/web/public && ( [ -e ./sources/web/public/index.php ] || (touch ./sources/web/public/index.php && echo "web">./sources/web/public/index.php))
	${DOCKER_COMPOSE} build

start:
	${DOCKER_COMPOSE} start

stop:
	${DOCKER_COMPOSE} stop

up:
	${DOCKER_COMPOSE} up -d --remove-orphans

down:
	${DOCKER_COMPOSE} down

restart: stop start

ps:
	${DOCKER_COMPOSE} ps

logs:
	${DOCKER_COMPOSE} logs -f

down_remove:
	${DOCKER_COMPOSE} down -v --rmi=all --remove-orphans

restart:
	make stop start

##################
# App
##################

app_bash:
	${DOCKER_COMPOSE} exec -u www-data php-fpm bash

nginx:
	${DOCKER_COMPOSE} exec -u www-data nginx bash

nginx_logs_access:
	${DOCKER_COMPOSE} exec -u www-data nginx tail -F /var/log/nginx/project_access.log

nginx_logs_errors:
	${DOCKER_COMPOSE} exec -u www-data nginx tail -F /var/log/nginx/project_error.log

php: app_bash

