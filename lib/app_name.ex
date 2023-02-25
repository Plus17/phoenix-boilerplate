defmodule AppName do
  @moduledoc """
  AppName keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Looks up `Application` config or raises if keyspace is not configured.
  ## Examples
      config :app_name, :seeds, admin_password: System.fetch_env!("ADMIN_PASSWORD")
      iex> AppName.config([:seeds, :admin_password])
  """
  @spec config(Keyword.t()) :: any()
  def config([main_key | rest] = keyspace) do
    main = Application.fetch_env!(:app_name, main_key)

    Enum.reduce(rest, main, fn next_key, current ->
      case Keyword.fetch(current, next_key) do
        {:ok, value} -> value
        :error -> raise ArgumentError, "no config found under #{inspect(keyspace)}"
      end
    end)
  end
end
