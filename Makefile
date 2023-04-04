include .env

.PHONY: install-dependencies env/setup dev

install-dependencies:
	bundle install
	yarn install
	gem install foreman

env/setup:
	./bin/envsetup.sh
	rails db:setup
	rails i18n:js:export

dev:
	./bin/dev.sh
