defmodule AppNameWeb.UserAuth do
  use AppNameWeb, :verified_routes

  import Plug.Conn
  import Phoenix.Controller

  alias AppName.Contexts.Accounts

  # Make the remember me cookie valid for 60 days.
  # If you want bump or reduce this value, also change
  # the token expiry itself in UserToken.
  @max_age 60 * 60 * 24 * 60
  @remember_me_cookie "_app_name_web_user_remember_me"
  @remember_me_options [sign: true, max_age: @max_age, same_site: "Lax"]

  @doc """
  Logs the user in.

  It renews the session ID and clears the whole session
  to avoid fixation attacks. See the renew_session
  function to customize this behaviour.

  It also sets a `:live_socket_id` key in the session,
  so LiveView sessions are identified and automatically
  disconnected on log out. The line can be safely removed
  if you are not using LiveView.
  """
  def log_in_user(conn, user) do
    token = Accounts.generate_user_session_token(user)

    conn
    |> renew_session()
    |> put_session(:user_token, token)
    |> put_session(:live_socket_id, "users_sessions:#{token}")
  end

  # This function renews the session ID and erases the whole
  # session to avoid fixation attacks. If there is any data
  # in the session you may want to preserve after login/logout,
  # you must explicitly fetch the session data before clearing
  # and then immediately set it after clearing, for example:
  #
  #     def renew_session(conn) do
  #       preferred_locale = get_session(conn, :preferred_locale)
  #
  #       conn
  #       |> configure_session(renew: true)
  #       |> clear_session()
  #       |> put_session(:preferred_locale, preferred_locale)
  #     end
  #
  defp renew_session(conn) do
    user_return_to = get_session(conn, :user_return_to)

    conn
    |> configure_session(renew: true)
    |> clear_session()
    |> put_session(:user_return_to, user_return_to)
  end

  @doc """
  Returns to or redirects home and potentially set remember_me token.
  """
  def redirect_user_after_login_with_remember_me(conn, params \\ %{}) do
    user_return_to = get_session(conn, :user_return_to)

    conn
    |> maybe_remember_user(params)
    |> delete_session(:user_return_to)
    |> redirect(to: user_return_to || signed_in_path(conn))
  end

  defp maybe_remember_user(conn, %{"remember_me" => "true"}) do
    token = get_session(conn, :user_token)
    put_resp_cookie(conn, @remember_me_cookie, token, @remember_me_options)
  end

  defp maybe_remember_user(conn, _params) do
    conn
  end

  @doc """
  Logs the user out.

  It clears all session data for safety. See renew_session.
  """
  def log_out_user(conn) do
    user_token = get_session(conn, :user_token)
    user_token && Accounts.delete_session_token(user_token)

    if live_socket_id = get_session(conn, :live_socket_id) do
      AppNameWeb.Endpoint.broadcast(live_socket_id, "disconnect", %{})
    end

    conn
    |> renew_session()
    |> delete_resp_cookie(@remember_me_cookie)
    |> redirect(to: "/")
  end

  @doc """
  Authenticates the user by looking into the session
  and remember me token.
  """
  def fetch_current_user(conn, _opts) do
    {user_token, conn} = ensure_user_token(conn)
    user = user_token && Accounts.get_user_by_session_token(user_token)
    assign(conn, :current_user, user)
  end

  defp ensure_user_token(conn) do
    if user_token = get_session(conn, :user_token) do
      {user_token, conn}
    else
      conn = fetch_cookies(conn, signed: [@remember_me_cookie])

      if user_token = conn.cookies[@remember_me_cookie] do
        {user_token, put_session(conn, :user_token, user_token)}
      else
        {nil, conn}
      end
    end
  end

  @doc """
  Used for routes that require the user to not be authenticated.
  """
  def redirect_if_user_is_authenticated(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
      |> redirect(to: signed_in_path(conn))
      |> halt()
    else
      conn
    end
  end

  @doc """
  Used for routes that require the user to be authenticated.

  If you want to enforce the user email is confirmed before
  they use the application at all, here would be a good place.
  """
  def require_authenticated_user(conn, _opts) do
    cond do
      is_nil(conn.assigns[:current_user]) ->
        conn
        |> put_flash(:error, "You must log in to access this page.")
        |> maybe_store_user_return_to()
        |> redirect(to: ~p"/users/log_in")
        |> halt()

      get_session(conn, :user_totp_pending) && conn.path_info != ["users", "totp"] &&
          conn.path_info != ["users", "logout"] ->
        conn
        |> redirect(to: ~p"/users/totp")
        |> halt()

      true ->
        conn
    end
  end

  @doc """
  Stores return to in the session as long as it is a GET request
  and the user is not authenticated.
  """
  def maybe_store_user_return_to(conn, _opts) do
    maybe_store_user_return_to(conn)
  end

  defp maybe_store_user_return_to(%{assigns: %{current_user: %{}}} = conn), do: conn

  defp maybe_store_user_return_to(%{method: "GET"} = conn) do
    %{request_path: request_path, query_string: query_string} = conn
    return_to = if query_string == "", do: request_path, else: request_path <> "?" <> query_string
    put_session(conn, :user_return_to, return_to)
  end

  defp maybe_store_user_return_to(conn), do: conn

  defp signed_in_path(_conn), do: "/"
end
