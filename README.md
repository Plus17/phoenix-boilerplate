## Content

This boilerplate comes with batteries included, you’ll find:

- [Phoenix](https://phoenixframework.org)
- Database integration with [Ecto](https://github.com/elixir-ecto/ecto)
- Translations with [Gettext](https://github.com/elixir-gettext/gettext)
- Tests factories using [ExMachina](https://github.com/thoughtbot/ex_machina) and code coverage using [ExCoveralls](https://github.com/parroty/excoveralls)
- CORS management with [CorsPlug](https://github.com/mschae/cors_plug)
- Static code analysis with [Credo](https://github.com/rrrene/credo)
- Releases using [`mix release`](https://hexdocs.pm/mix/Mix.Tasks.Release.html) and [Docker](https://www.docker.com)


## Configurations

- warnings_as_errors: true

## Useful libraries

Here is an opinionated list of othe usefuel library's to consider:

| Category                    | Libraries                                                                              |
| --------------------------- | -------------------------------------------------------------------------------------- |
| Authentication              | [`ueberauth`](https://github.com/ueberauth/ueberauth)                                  |
| Emails                      | [`bamboo`](https://github.com/thoughtbot/bamboo), [`swoosh`](https://github.com/swoosh/swoosh) |
| HTTP client                 | [`Tesla`](https://github.com/teamon/tesla)                                   |
| Job processing              | ['Oban'](https://github.com/sorentwo/oban)
| Pagination                  | [`Scrivener`](https://github.com/drewolson/scrivener)                                  |
| Mocks                       | [`Mox`](https://github.com/dashbitco/mox), [`Mimic`](https://github.com/edgurgel/mimic)   |


## Development with Docker

### Makefile

For convenience, you can use the commands included in the Makefile:

| Command                                                           | Description                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------- |
| `make bootstrap`                                                  | Bootstrap the phoenix project (dependencies & databse)|
| `make deps.get`                                                   | Gets & compile dependencies                           |
| `make deps.clean`                                                 | Clean unused dependencies & remove from mix.lock      |
| `make seeds`                                                      | Run seeds                                             |
| `make reset`                                                      | Resets the project removing deps & builds             |
| `make ecto.setup`                                                 | Setup the database for dev                            |
| `make ecto.reset`                                                 | Resets the database for dev                           |
| `make ecto.reset.test`                                            | Resets the database for test                          |
| `make test`                                                       | Runs tests                                            |
| `make check.all`                                                  | Run all CI verifications (formatter, credo, coverage) |
| `make run`                                                        | Start **Phoenix** server                              |
| `make gettext`                                                    | Search & merge new translations                       |
| `make format`                                                     | Format all phoenix files                              |


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
