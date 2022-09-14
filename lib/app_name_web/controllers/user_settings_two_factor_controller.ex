defmodule AppNameWeb.UserSettingsTwoFactorController do
  use AppNameWeb, :controller

  alias AppName.Handlers.Users.TwoFactorHander

  def new(conn, _params) do
    secret = NimbleTOTP.secret()

    uri =
      NimbleTOTP.otpauth_uri("AppName:#{conn.assigns.current_user.email}", secret,
        issuer: "AppName"
      )

    conn
    |> put_session(:totp_secret, secret)
    |> render("new.html", uri: uri)
  end

  def create(conn, %{"user" => %{"otp" => otp}}) do
    secret = get_session(conn, :totp_secret)

    case TwoFactorHander.setup(conn.assigns.current_user, secret, otp) do
      {:ok, :success} ->
        conn
        |> delete_session(:totp_secret)
        |> put_flash(:info, "2FA activated successfully.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))

      {:error, :invalid_otp} ->
        conn
        |> delete_session(:totp_secret)
        |> put_flash(:error, "OTP code is invalid")
        |> redirect(to: Routes.user_settings_two_factor_path(conn, :new))
    end
  end

  def delete(conn, _params) do
    case TwoFactorHander.deactivate(conn.assigns.current_user) do
      {:ok, _user} ->
        conn
        |> delete_session(:totp_secret)
        |> put_flash(:info, "2FA activated successfully.")
        |> redirect(to: Routes.user_settings_path(conn, :edit))
    end
  end
end
