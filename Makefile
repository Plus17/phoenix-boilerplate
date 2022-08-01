include .env

default: run

#### Bootstrap Commands

deps.get:
	docker-compose run --rm phx sh -c "mix deps.clean --unused \
	&& mix deps.get \
	&& mix deps.compile"

ecto.setup:
	docker-compose run --rm phx sh -c "mix ecto.setup"

npm.install:
	docker-compose run --rm -T --no-deps phx bash -c "cd /app/src/assets && \
	npm install"

bootstrap: deps.get ecto.setup npm.install

gen.secret:
	docker-compose run --rm --no-deps phx sh -c "mix phx.gen.secret"

reset:
	cd backend/ && rm -rf /deps/* && rm -rf /_build/dev/* && rm -rf /_build/test/*

#### CI/CD Commands

compile:
	docker-compose run --rm phx sh -c "mix compile"

check.formatter:
	docker-compose run --rm --no-deps phx sh -c "mix format --check-formatted"

credo:
	docker-compose run --rm --no-deps phx sh -c "mix credo --strict"

coverage:
	docker-compose run --rm phx sh -c "MIX_ENV=test mix coveralls.html"

check.all: compile check.formatter credo coverage

#### Development Commands

seeds:
	docker-compose run --rm phx sh -c "mix seeds"

run:
	docker-compose run --rm --service-ports phx sh -c "mix phx.server"

deps.clean:
	docker-compose run --rm phx sh -c "mix deps.clean --unlock --unused"

ecto.migrate:
	docker-compose run --rm phx sh -c "mix ecto.migrate"

ecto.reset:
	docker-compose run --rm phx sh -c "mix ecto.reset"

ecto.reset.test:
	docker-compose run --rm phx sh -c "MIX_ENV=test mix ecto.reset"

shell.phx:
	docker-compose run --rm phx bash

assets.deploy:
	docker-compose run --rm -T --no-deps phx bash -c "mix assets.deploy"

format:
	docker-compose run --rm --no-deps phx sh -c "mix format"

test:
	docker-compose run --rm phx sh -c "MIX_ENV=test mix test"

test.failed:
	docker-compose run --rm phx sh -c "mix test --failed"

gettext:
	docker-compose run --rm phx sh -c "mix gettext.extract --merge"

.PHONY: test
