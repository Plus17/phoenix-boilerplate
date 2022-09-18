defmodule AppNameWeb.ErrorViewTest do
  use AppNameWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(AppNameWeb.ErrorView, "404.html", []) == "Not Found"
  end

  test "renders 500.html" do
    assert render_to_string(AppNameWeb.ErrorView, "500.html", []) == "Internal Server Error"
  end

  test "renders error.json" do
    assert render_to_string(AppNameWeb.ErrorView, "error.json",
             message: "External service is not available"
           ) ==
             ~s[{"data":null,"errors":null,"message":"External service is not available","status":"error"}]
  end
end
