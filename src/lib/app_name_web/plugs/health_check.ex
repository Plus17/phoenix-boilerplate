defmodule AppNameWeb.Plugs.HealthCheck do
  @moduledoc """
  Health endpoint
  """
  import Plug.Conn

  @spec init(Keyword.t()) :: Keyword.t()
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), Keyword.t()) :: Plug.Conn.t()
  def call(%Plug.Conn{request_path: "/health"} = conn, _opts) do
    conn
    |> send_resp(200, "")
    |> halt()
  end

  def call(conn, _opts), do: conn
end
