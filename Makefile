.PHONY: help test

help:
	@perl -nle'print $& if m{^[a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

setup: ## Setup the project
	[ -f .env ] || cp .env.dist .env
	docker compose run --rm phx sh -c "mix setup"

ci: ## Run the CI
	docker compose run --rm phx sh -c "mix ci"

reset: ## Reset the phx container
	docker compose run --rm --no-deps phx sh -c "rm -rf _build deps"
	docker compose stop phx
	docker compose rm -f phx

deps.get:
	docker compose run --rm --no-deps phx sh -c "mix deps.get"

deps.clean.unused: ## Clean unused dependencies
	docker compose run --rm phx sh -c "mix deps.unlock --unused && mix deps.clean --unused"

test: ## Run the tests
	docker compose run --rm phx sh -c "mix test"

run: ## Run the server
	docker compose run --rm --service-ports phx iex -S mix phx.server

console: ## Start the iex console
	docker compose run --rm phx iex -S mix

shell: ## Start the phx shell
	docker compose run --rm phx sh

format: ## Run elixir formatter
	docker compose run --rm --no-deps phx sh -c "mix format"

gen.secret:
	docker compose run --rm --no-deps phx sh -c "mix phx.gen.secret"

build.local.release: ## Build a local release
	docker build -t app_name:latest .

run.local.release: ## Run the local release
	docker run -it -p 4000:4000 --env DATABASE_URL=ecto://postgres:postgres@host.docker.internal:5432/app_name_dev --env SECRET_KEY_BASE=wzZoRzPzvYDOq1/eeLrPsgv+4mUqx3GSoqq/Uijrm39a4xCCcNHXLR43tSa3KwQx --env PHX_HOST=localhost app_name:latest
