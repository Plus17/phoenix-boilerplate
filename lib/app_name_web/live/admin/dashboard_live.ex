defmodule AppNameWeb.Admin.DashboardLive do
  @moduledoc """
  Dashboard live for admins
  """

  use AppNameWeb, :live_view

  alias AppNameWeb.Components.Users.UserListComponent

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :component_to_show, nil)}
  end

  @impl true
  def handle_event("show_component", %{"component_to_show" => component_to_show}, socket) do
    component_to_show = String.to_existing_atom(component_to_show)
    {:noreply, assign(socket, :component_to_show, component_to_show)}
  end
end
