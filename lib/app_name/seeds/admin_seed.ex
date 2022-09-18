defmodule AppName.Seeds.AdminSeed do
  @moduledoc """
  Seed to create an universal admin user with the configured password in env vars.

  ## Usage

    iex> AppName.Seeds.AdminSeed.run()
      #AppName.Contexts.Users.User<...>
  """

  require Logger

  alias AppName.Contexts.Users
  alias AppName.Contexts.Users.UserManager

  @admin_params %{
    "password" => "",
    "email" => "admin@email.mx",
    "first_name" => "Super",
    "first_surname" => "Admin",
    "is_admin" => true
  }

  @doc """
  Runs the seeds
  """
  @spec run() :: User.t()
  def run() do
    Logger.debug("[AdminSeed] running")

    case Users.get_user_by_email(@admin_params["email"]) do
      nil ->
        password = AppNameConfig.fetch_seeds!(:admin_password)

        String.length(password)

        params = Map.put(@admin_params, "password", password)

        {:ok, admin} = UserManager.create_admin(params)
        admin

      admin ->
        Logger.warn("[AdminSeed] admin user already exists")
        admin
    end
  end
end
