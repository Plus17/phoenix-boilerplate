defmodule AppNameWeb.PageController do
  use AppNameWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
