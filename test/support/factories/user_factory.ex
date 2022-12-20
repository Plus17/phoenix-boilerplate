defmodule AppName.UserFactory do
  @moduledoc """
  User factory to populate test data
  """

  alias AppName.Contexts.Accounts.User

  alias AppName.Schemas.Users.Settings

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          email: sequence(:email, &"user#{&1}@example.com"),
          hashed_password:
            "$argon2id$v=19$m=65536,t=8,p=2$CH+c9Kx5QTJhQvKxQgbe9A$/I7GNjrwptBIDz8Q3C1ds31z1Vy427rpmumQcK86aGA",
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
