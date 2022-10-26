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
  @spec list(Keyword.t()) :: [User.t()]
  def list(opts \\ []) when is_list(opts) do
    opts |> IO.inspect(label: "OPTS")
    limit = Keyword.get(opts, :limit, 10)

    User
    |> order_by(:inserted_at)
    |> Repo.paginate(cursor_fields: [:inserted_at, :id], limit: limit)
  end


  @spec list(map(), Keyword.t()) :: [User.t()]
  def list(params, opts \\ [])

  def list(%{after: cursor_after}, opts) when is_binary(cursor_after) do
    limit = Keyword.get(opts, :limit, 10)

    User
    |> order_by(:inserted_at)
    |> Repo.paginate(after: cursor_after, cursor_fields: [:inserted_at, :id], limit: limit)
  end

  def list(%{before: cursor_before}, opts) when is_binary(cursor_before) do
    limit = Keyword.get(opts, :limit, 10)

    User
    |> order_by(:inserted_at)
    |> Repo.paginate(before: cursor_before, cursor_fields: [:inserted_at, :id], limit: limit)
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
