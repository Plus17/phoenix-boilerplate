## Content

This boilerplate comes with batteries included, you’ll find:

- [Phoenix](https://phoenixframework.org)
- Database integration with [Ecto](https://github.com/elixir-ecto/ecto)
- Translations with [Gettext](https://github.com/elixir-gettext/gettext)
- Static code analysis with [Credo](https://github.com/rrrene/credo)
- Releases using [`mix release`](https://hexdocs.pm/mix/Mix.Tasks.Release.html) and [Docker](https://www.docker.com)
- [Tailwindcss](https://tailwindcss.com/)
- [O]

## Configurations

- warnings_as_errors: true

## Useful libraries

Here is an opinionated list of other useful libraries to consider:

| Category                    | Libraries                                                                              |
| --------------------------- | -------------------------------------------------------------------------------------- |
| OAuth2 Authentication       | [`ueberauth`](https://github.com/ueberauth/ueberauth)                                  |
| Token based auth            | [`Guardian`](https://github.com/ueberauth/guardian)                                    |
| Safety migrations           | [`strong_migrations`](https://github.com/fresha/strong_migrations)                     |
| HTTP client                 | [`Req`](https://github.com/wojtekmach/req)                                   |
| Pagination                  | [`Scrivener`](https://github.com/drewolson/scrivener) (limit/offset), [Flop Phoenix](https://github.com/woylie/flop_phoenixo)|
| Mocks                       | [`Mox`](https://github.com/dashbitco/mox), [`Mimic`](https://github.com/edgurgel/mimic)   |
| Cache                       | [Cachex](https://github.com/whitfin/cachex), [Nebulex](https://github.com/cabol/nebulex) (distributed cache)   |
| Date/Time                   | [Timex](https://github.com/bitwalker/timex)                                                         |
| CSV                         | [NimbleCSV](https://github.com/dashbitco/nimble_csv), [CSV](https://github.com/beatrichartz/csv)  |
| Feature Flags/Toggles       | [FunWithFlags](https://github.com/tompave/fun_with_flags)                             |
| Clustering                  | [libcluster](https://github.com/bitwalker/libcluster)                                 |

## Rename your porject
1. Open the script `rename.sh`
2. Change `NEW_NAME` & `NEW_OTP` variables with your app name
3. Execute the script `sh rename.sh`
3. Remove the file `rename.sh`

## Development with Docker

### Dependencies

1. Install [Docker](https://www.docker.com/products/docker-desktop)
2. Install Make: `sudo apt install make` or `brew install make`

### First run

1. Clone the project repository: `git clone git@github.com:Plus17/phoenix-boilerplate.git my_app`
2. Go to project dir: `cd my_app`
3. Execute: `make setup` to install dependencies, setup the database, execute migrations, etc.
5. Execute: `make run` to run the server at http://localhost:4000

### New environment variables

If you want to add new environment variables you need to put the new env var in some places:

1. In the `.env.dist` template file to include in new installations
2. In your `.env` file

NOTE: When you add a new env var you must restart the container, so the container can read the new variable.

### Makefile

For convenience, you can use the commands included in the Makefile:

| Command                                                           | Description                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------- |
| `make setup`                                                      | Setups the phoenix project (dependencies & database)  |
| `make deps.get`                                                   | Gets & compile dependencies                           |
| `make deps.clean`                                                 | Clean unused dependencies & remove from mix.lock      |
| `make seeds`                                                      | Run seeds                                             |
| `make reset`                                                      | Resets the project removing deps & builds             |
| `make ecto.setup`                                                 | Setup the database for dev                            |
| `make ecto.reset`                                                 | Resets the database for dev                           |
| `make ecto.reset.test`                                            | Resets the database for test                          |
| `make test`                                                       | Runs tests                                            |
| `make ci`                                                         | Run all CI verifications (formatter, credo, coverage) |
| `make run`                                                        | Start **Phoenix** server                              |
| `make gettext`                                                    | Search & merge new translations                       |
| `make format`                                                     | Format all phoenix files                              |

## Development without Docker

### Dependencies

1. Install [asdf](https://asdf-vm.com/guide/getting-started.html#_1-install-dependencies)
2. Add the [asdf erlang plugin](https://github.com/asdf-vm/asdf-erlang) `asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git`
3. Add the [asdf elixir plugin](https://github.com/asdf-vm/asdf-elixir) `asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git`


### First run

1. Clone the project repository: `git clone git@github.com:Plus17/phoenix-boilerplate.git my_app`
2. Go to project dir: `cd my_app`
3. Install Erlang & Elixir according to the `Dockerfile.dev` file with: `asdf install erlang 27.2` & `asdf install elixir 1.18.1`
6. Run `source .env` on project root folder
7. Run `mix local.hex && mix local.rebar`
8. Run `mix setup` to download dependencies & setup database
9. Run `mix phx.server`

### New environment variables

If you want to add new environment variables you need to put the new env var in some places:

1. In the `.env.dist` template file to include in new installations
2. In your `.env` file.

# AppName

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
