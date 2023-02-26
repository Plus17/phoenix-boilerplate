defmodule Mix.Tasks.CI do
  @moduledoc "The CI mix task: `mix help CI`"

  use Mix.Task

  @doc """
  Execute all CI verifications:

  1. compile the code with warnings_as_errors: true (see mix.exs)
  2. Verifify code is formatted
  3. Run credo verifications in strict mode
  4. Setup the database
  5. Run test with --warnings-as-errors flag (see mix.exs)
  6. Verifify migrations are reversible
  """
  @spec run(any()) :: any()
  def run(_args) do
    print_blue("Compiling code ...")

    Mix.Task.run("compile")

    print_blue("Verifing code is formatted ...")

    Mix.Task.run("format", ["--check-formatted"])

    print_blue("Runing credo in strict mode ...")

    Mix.Task.run("credo", ["--strict"])

    print_blue("Setups database ...")

    Mix.Task.run("cmd", ["MIX_ENV=test", "mix ecto.setup"])

    print_blue("Runing tests ...")

    Mix.Task.run("cmd", ["MIX_ENV=test", "mix test"])

    print_blue("Verifing migrations are reversible ...")

    Mix.Task.run("cmd", ["MIX_ENV=test", "mix ecto.rollback --all"])
  end

  defp print_blue(text) do
    text = IO.ANSI.blue() <> text <> IO.ANSI.reset()

    IO.puts(text)
  end
end
