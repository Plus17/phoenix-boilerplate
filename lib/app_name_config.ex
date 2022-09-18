defmodule AppNameConfig do
  @moduledoc """
  AppNameConfig is the central entry point to configuration settings (environment variables, etc.)
  """

  @doc """
  Returns the config values for seeds
  """
  @spec fetch_seeds!() :: String.t()
  @spec fetch_seeds!(atom()) :: String.t()
  def fetch_seeds!() do
    Application.fetch_env!(:app_name, :seeds)
  end

  def fetch_seeds!(key) when is_atom(key) do
    :app_name
    |> Application.fetch_env!(:seeds)
    |> Keyword.fetch!(key)
  end
end
