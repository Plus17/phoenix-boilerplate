defmodule AppNameWeb.Admin.UserLiveTest do
  use AppNameWeb.ConnCase

  setup :register_and_log_in_admin_user

  test "disconnected and connected mount", %{conn: conn} do
    insert_list(20, :user)

    conn = get(conn, Routes.admin_live_path(@endpoint, AppNameWeb.Admin.UserLive))

    response = html_response(conn, 200)

    assert response =~ "Registered users"
    assert response =~ "<button class=\"btn btn-outline\" disabled>Previous page</button>"
    refute response =~ "<button class=\"btn btn-outline\" disabled>Next</button>"

    {:ok, view, _html} = live(conn)

    assert view
           |> element("button", "Next")
           |> render_click() =~
             "<button class=\"btn btn-outline\" disabled=\"disabled\">Next</button>"
  end
end
