include .env

.PHONY: install-dependencies env/setup env/teardown dev test

install-dependencies:
	bundle install
	yarn install
	gem install foreman

env/start:
	./bin/envsetup.sh

env/setup:
	make env/start
	rails db:setup
	rails i18n:js:export

env/stop:
	./bin/envstop.sh

env/teardown:
	./bin/envteardown.sh

dev:
	make env/start
	./bin/dev.sh

test:
	docker-compose -f docker-compose.test.yml --project-name nimble-survey-web-test up -d db redis
	bundle exec rspec $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
	docker-compose -f docker-compose.test.yml --project-name nimble-survey-web-test down
