defmodule AppName.Repo do
  use Ecto.Repo,
    otp_app: :app_name,
    adapter: Ecto.Adapters.Postgres

  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.fetch_env!("POSTGRES_URL"))}
  end
end
