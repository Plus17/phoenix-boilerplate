defmodule AppNameWeb.UserSettingsTwoFactorControllerTest do
  use AppNameWeb.ConnCase, async: true

  setup :register_and_log_in_user

  describe "new" do
    test "when user has 2FA", %{conn: conn} do
      response =
        conn
        |> get(~p"/users/settings/two_factor_auth/new")
        |> html_response(200)

      assert response =~ "Two-factor authentication"
    end
  end

  describe "create" do
    test "when user enter bad code", %{conn: conn} do
      conn = post(conn, ~p"/users/settings/two_factor_auth", user: %{"otp" => "12345"})

      assert redirected_to(conn) == ~p"/users/settings/two_factor_auth/new"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) == "OTP code is invalid"
    end

    test "when user enter rigth code", %{conn: conn} do
      get_conn = get(conn, ~p"/users/settings/two_factor_auth/new")

      secret = get_session(get_conn, :totp_secret)

      valid_code = NimbleTOTP.verification_code(secret)

      conn = post(get_conn, ~p"/users/settings/two_factor_auth", user: %{"otp" => valid_code})

      assert redirected_to(conn) == ~p"/users/settings"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) == "2FA activated successfully."
    end
  end
end
