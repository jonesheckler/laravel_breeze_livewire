# Run only when setting up the application
initialize:
	@docker-compose up --build -d
	@docker-compose exec php \
		cp .env.example .env
	@docker-compose exec php \
		composer install
	@docker-compose exec php \
		php artisan key:generate
	@docker-compose exec php \
		php artisan storage:link
	@docker-compose exec php \
		php artisan migrate:fresh --seed
	@docker-compose exec db \
		mysql --user="root" --password="secret" --execute "create database if not exists test;"

up:
	@docker-compose up --build -d
down:
	@docker-compose down

install:
	@docker-compose exec php composer install
update:
	@docker-compose exec php composer update

bash:
	@docker-compose exec php bash

test:
	@docker-compose exec php ./vendor/bin/phpstan analyze && docker-compose exec php ./vendor/bin/phpunit

coverage:
	@docker-compose exec -e XDEBUG_MODE=coverage php ./vendor/bin/phpunit --coverage-html=cov && \
		echo "Openning in Chrome: ./cov/index.html" && \
		open --new -a "Google Chrome" ./cov/index.html

