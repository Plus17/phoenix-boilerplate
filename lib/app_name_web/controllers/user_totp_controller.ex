defmodule AppNameWeb.UserTOTPController do
  use AppNameWeb, :controller

  plug :redirect_if_totp_is_not_pending

  alias AppNameWeb.UserAuth

  def new(conn, _params) do
    render(conn, :new, error_message: nil)
  end

  def create(conn, %{"user" => %{"code" => code} = user_params}) do
    totp_secret = conn.assigns.current_user.totp_secret

    if NimbleTOTP.valid?(totp_secret, code) do
      conn
      |> delete_session(:user_totp_pending)
      |> UserAuth.redirect_user_after_login_with_remember_me(user_params)
    else
      render(conn, :new, error_message: "Invalid two-factor authentication code")
    end
  end

  defp redirect_if_totp_is_not_pending(conn, _opts) do
    if get_session(conn, :user_totp_pending) do
      conn
    else
      conn
      |> redirect(to: ~p"/")
      |> halt()
    end
  end
end
