defmodule AppNameWeb.InitAssigns do
  @moduledoc """
  Ensures common `assigns` are applied to all LiveViews attaching this hook.
  """
  import Phoenix.LiveView

  require Logger

  # credo:disable-for-next-line
  alias AppNameWeb.Router.Helpers, as: Routes

  alias AppName.Contexts.Users

  @spec on_mount(atom(), map, map, Phoenix.LiveView.Socket.t()) :: {:cont, map}
  def on_mount(:admin, _params, %{"user_token" => user_token} = _session, socket) do
    Logger.debug("[InitAssigns] on mount hook for admin user assigns")
    user = Users.get_user_by_session_token(user_token)

    if user && user.is_admin do
      Logger.debug("[InitAssigns] current admin user")
      {:cont, assign(socket, :current_user, user)}
    else
      Logger.debug("[InitAssigns] No current admin user, halting")
      {:halt, redirect(socket, to: Routes.user_session_path(socket, :new))}
    end
  end
end
