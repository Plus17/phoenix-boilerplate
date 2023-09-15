defmodule AppName.UserFactory do
  @moduledoc """
  User factory to populate test data
  """

  alias AppName.Accounts.User

  alias AppName.Schemas.Users.Settings

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          email: sequence(:email, &"user#{&1}@example.com"),
          hashed_password: "$2a$12$nhd/WZUYJ1GbPvJnvdMEi.PdoYEzaExB28r/Mt/DgTTI88Gq18FgS",
          settings: %Settings{has_2fa: false},
          totp_secret: nil
        }
      end

      def with_2fa(user) do
        %{user | totp_secret: NimbleTOTP.secret(), settings: %Settings{has_2fa: true}}
      end
    end
  end
end
