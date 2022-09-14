defmodule AppNameWeb.UserSettingsTwoFactorControllerTest do
  use AppNameWeb.ConnCase, async: true

  setup :register_and_log_in_user

  describe "new" do
    test "when user has 2FA", %{conn: conn} do
      response =
        conn
        |> get(Routes.user_settings_two_factor_path(conn, :new))
        |> html_response(200)

      assert response =~ "Two-factor authentication"
    end
  end

  describe "create" do
    test "when user enter bad code", %{conn: conn} do
      response =
        conn
        |> post(Routes.user_settings_two_factor_path(conn, :create), user: %{"otp" => "12345"})

      assert redirected_to(response) == Routes.user_settings_two_factor_path(conn, :new)
      assert get_flash(response, :error) =~ "OTP code is invalid"
    end

    test "when user enter rigth code", %{conn: conn} do
      get_conn = get(conn, Routes.user_settings_two_factor_path(conn, :new))

      secret = get_session(get_conn, :totp_secret)

      valid_code = NimbleTOTP.verification_code(secret)

      response =
        get_conn
        |> post(Routes.user_settings_two_factor_path(conn, :create), user: %{"otp" => valid_code})

      assert redirected_to(response) == Routes.user_settings_path(conn, :edit)
      assert get_flash(response, :info) =~ "2FA activated successfully."
    end
  end
end
