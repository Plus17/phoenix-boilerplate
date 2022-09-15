defmodule AppNameWeb.FallbackController do
  @moduledoc """
  Generate valid responses with `Plug.Conn`
  """
  use AppNameWeb, :controller

  @doc """
  Returns a response with the changeset errors
  """
  @spec call(Plug.Conn.t(), Ecto.Changeset.t()) :: String.t()
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(AppNameWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  @spec call(Plug.Conn.t(), tuple()) :: String.t()
  def call(conn, {:success, module, view, assigns}) do
    conn
    |> put_status(200)
    |> put_view(module)
    |> render(view, assigns)
  end

  @spec call(Plug.Conn.t(), tuple) :: String.t()
  def call(conn, {:created, module, view, assigns}) do
    conn
    |> put_status(:created)
    |> put_view(module)
    |> render(view, assigns)
  end

  # Returns a custom bad request response with status 400
  def call(conn, {:error, message}) do
    conn
    |> put_status(:bad_request)
    |> put_view(AppNameWeb.ErrorView)
    |> render("error.json", %{message: message})
  end
end
