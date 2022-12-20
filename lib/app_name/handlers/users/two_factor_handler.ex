defmodule AppName.Handlers.Users.TwoFactorHander do
  @moduledoc """
  Handler for Two Factor
  """

  require Logger

  alias AppName.Contexts.Accounts.User

  alias AppName.Contexts.Accounts

  @doc """
  Verify cod and save secret
  """
  @spec setup(User.t(), String.t(), String.t()) :: {:ok, User.t()}
  def setup(%User{} = user, secret, otp) do
    Logger.debug("[TwoFactorHander.setup/3] Validating secret: #{secret}, otp: #{otp}")

    with {:ok, :valid} <- validate_otp(secret, otp),
         {:ok, user} <- Accounts.setup_two_factor(user, secret) do
      Logger.info("[TwoFactorHander] Success 2FA setup for user #{user.id}")
      {:ok, :success}
    end
  end

  # Validate OTP code
  @spec validate_otp(String.t(), String.t()) :: {:ok, :valid} | {:error, String.t()}
  defp validate_otp(secret, otp) do
    if NimbleTOTP.valid?(secret, otp) do
      {:ok, :valid}
    else
      Logger.warn("[TwoFactorHander.validate_otp/2] Invalid otp code")
      {:error, :invalid_otp}
    end
  end

  @doc """
  Deactivate Two factor authentication for the given user
  """
  @spec deactivate(User.t()) :: {:ok, User.t()}
  def deactivate(%User{} = user) do
    Logger.debug("[TwoFactorHander.deactivate/1] Deactivating two factor for user #{user.id}")
    Accounts.deactivate_two_factor(user)
  end
end
