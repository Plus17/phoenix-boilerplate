defmodule AppName.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AppNameWeb.Telemetry,
      # Start the Ecto repository
      AppName.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: AppName.PubSub},
      # Start Finch
      {Finch, name: AppName.Finch},
      # Start the Endpoint (http/https)
      AppNameWeb.Endpoint
      # Start a worker by calling: AppName.Worker.start_link(arg)
      # {AppName.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AppName.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AppNameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
