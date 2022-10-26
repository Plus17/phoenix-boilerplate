defmodule AppNameWeb.Components.Users.UserListComponent do
  @moduledoc """
  Component for list users
  """
  use AppNameWeb, :live_component

  alias Phoenix.LiveView.JS

  alias AppName.Contexts.Users.UserManager

  @impl true
  def preload(list_of_assigns) do
    Enum.map(list_of_assigns, fn assigns ->
      Map.put(assigns, :users, list_users())
    end)
  end

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("next_page", %{"next_page" => next_page}, socket) when is_binary(next_page)  do
    users = UserManager.list(%{after: next_page}, limit: 1)

    {:noreply, assign(socket, :users, users)}
  end

  @impl true
  def handle_event("prev_page", %{"prev_page" => prev_page}, socket) when is_binary(prev_page)  do
    users = UserManager.list(%{before: prev_page}, limit: 1)

    {:noreply, assign(socket, :users, users)}
  end

  def pass_page(js \\ %JS{}) do
    js
    |> JS.hide(transition: "fade-out", to: "#user-content")
  end

  defp list_users() do
    UserManager.list()
  end

  def confirmed_user(user) do
    if user.confirmed_at do
      "Yes"
    else
      "No"
    end
  end
end
