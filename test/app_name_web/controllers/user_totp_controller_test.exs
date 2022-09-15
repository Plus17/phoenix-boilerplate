defmodule AppNameWeb.UserTOTPControllerTest do
  use AppNameWeb.ConnCase, async: true

  describe "new" do
    test "when user has 2FA", %{conn: conn} do
      user = user_with_2fa()

      response =
        conn
        |> log_in_user(user)
        |> put_session(:user_totp_pending, true)
        |> get(Routes.user_totp_path(conn, :new))
        |> html_response(200)

      assert response =~ "Enter the six-digit code from your device"
    end
  end

  describe "create" do
    test "when user enter bad code", %{conn: conn} do
      user = user_with_2fa()

      get_conn =
        conn
        |> log_in_user(user)
        |> put_session(:user_totp_pending, true)
        |> get(Routes.user_totp_path(conn, :new))

      response =
        get_conn
        |> post(Routes.user_totp_path(conn, :create), user: %{"code" => "12345"})
        |> html_response(200)

      assert response =~ "Invalid two-factor authentication code"
    end

    test "when user enter the correct code", %{conn: conn} do
      user = user_with_2fa()

      get_conn =
        conn
        |> log_in_user(user)
        |> put_session(:user_totp_pending, true)
        |> get(Routes.user_totp_path(conn, :new))

      valid_code = NimbleTOTP.verification_code(user.totp_secret)

      response =
        post(get_conn, Routes.user_totp_path(conn, :create), user: %{"code" => valid_code})

      assert redirected_to(response) == Routes.page_path(conn, :index)

      conn = get(recycle(response), Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ user.email
    end
  end

  defp user_with_2fa do
    :user
    |> build()
    |> with_2fa()
    |> insert()
  end
end
