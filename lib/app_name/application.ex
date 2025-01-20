defmodule AppName.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AppNameWeb.Telemetry,
      AppName.Repo,
      {DNSCluster, query: Application.get_env(:app_name, :dns_cluster_query) || :ignore},
      {Oban, Application.fetch_env!(:app_name, Oban)},
      {Phoenix.PubSub, name: AppName.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: AppName.Finch},
      # Start a worker by calling: AppName.Worker.start_link(arg)
      # {AppName.Worker, arg},
      # Start to serve requests, typically the last entry
      AppNameWeb.Endpoint
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
