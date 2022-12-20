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
    |> put_view(json: AppNameWeb.ChangesetJSON)
    |> render("error.json", changeset: changeset)
  end

  # This clause is an example of how to handle resources that cannot be found.
  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: AppNameWeb.ErrorHTML, json: AppNameWeb.ErrorJSON)
    |> render(:"404")
  end

  @spec call(Plug.Conn.t(), tuple()) :: String.t()
  def call(conn, {:success, module, view, assigns}) do
    conn
    |> put_status(200)
    |> put_view(json: module)
    |> render(view, assigns)
  end

  @spec call(Plug.Conn.t(), tuple) :: String.t()
  def call(conn, {:created, location, module, view, assigns}) do
    conn
    |> put_status(:created)
    |> put_resp_header("location", location)
    |> put_view(json: module)
    |> render(view, assigns)
  end
end
