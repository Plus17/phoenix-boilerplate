defmodule AppNameWeb.Admin.UserLive do
  @moduledoc """
  Dashboard User live for admins
  """

  use AppNameWeb, :live_view

  alias AppNameWeb.Components.Admin.NavComponent
  alias AppNameWeb.Components.Users.UserListComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end
