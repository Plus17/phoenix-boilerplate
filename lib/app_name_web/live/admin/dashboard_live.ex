defmodule AppNameWeb.Admin.DashboardLive do
  @moduledoc """
  Dashboard live for admins
  """

  use AppNameWeb, :live_view

  alias AppNameWeb.Components.Admin.NavComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
