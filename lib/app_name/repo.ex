defmodule AppName.Repo do
  use Ecto.Repo,
    otp_app: :app_name,
    adapter: Ecto.Adapters.Postgres

  use Paginator
end
