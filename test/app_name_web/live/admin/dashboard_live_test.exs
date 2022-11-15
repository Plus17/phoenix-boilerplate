defmodule AppNameWeb.Admin.DashboardLiveTest do
  use AppNameWeb.ConnCase

  setup :register_and_log_in_admin_user

  test "disconnected and connected mount", %{conn: conn} do
    conn = get(conn, Routes.admin_live_path(@endpoint, AppNameWeb.Admin.DashboardLive))

    assert html_response(conn, 200) =~ "Admin options</div>"
  end
end
