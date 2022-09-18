defmodule AppName.Contexts.Users.UserManager do
  @moduledoc """
  The Users context manager to CRUD operations.
  """

  import Ecto.Query, warn: false

  alias AppName.Repo

  alias AppName.Contexts.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list()
      [%User{}, ...]

  """
  @spec list() :: [User.t()]
  def list() do
    Repo.all(User)
  end

  @doc """
  Creates an admin user.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %User{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_admin(attrs) do
    %User{}
    |> User.admin_changeset(attrs)
    |> Repo.insert()
  end

end
