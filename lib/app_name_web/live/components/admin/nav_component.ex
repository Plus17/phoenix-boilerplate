defmodule AppNameWeb.Components.Admin.NavComponent do
  @moduledoc """
  Component for Admin Nav links
  """
  use AppNameWeb, :component

  def nav(assigns) do
    ~H"""
    <div class="flex-1 px-2 mx-2">Admin options</div>
    <div class="flex-none hidden lg:block">
      <ul class="menu menu-horizontal">
        <!-- Navbar menu content here -->
        <li>
          <.link navigate={Routes.admin_live_path(@socket, AppNameWeb.Admin.UserLive)} class="underline" replace={true}>Users</.link>
        </li>
      </ul>
    </div>
    """
  end
end
