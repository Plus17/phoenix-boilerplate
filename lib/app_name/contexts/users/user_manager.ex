defmodule AppName.Contexts.Users.UserManager do
  @moduledoc """
  The Users context manager to CRUD operations.
  """

  import Ecto.Query, warn: false

  alias AppName.Repo

  alias AppName.Contexts.Users.User

  @default_opts [
    before: nil,
    after: nil,
    filters: [],
    limit: 10,
    sort: %{sort_by: :inserted_at, sort_order: :asc}
  ]

  @doc """
  Returns the list of users.

  ## Examples

      iex> list()
      [%User{}, ...]

  """
  @spec list(Keyword.t()) :: [User.t()]
  def list(opts \\ @default_opts) when is_list(opts) do
    opts = Keyword.merge(@default_opts, opts)
    filters = Keyword.fetch!(opts, :filters)

    %{sort_by: sort_by, sort_order: sort_order} = Keyword.get(opts, :sort)

    User
    |> where([], ^filters)
    |> order_by([{^sort_order, ^sort_by}])
    |> paginate(opts)
  end

  # Paginate query
  @spec paginate(Ecto.Query.t(), Keyword.t()) :: [User.t()]
  defp paginate(query, opts) do
    limit = Keyword.get(opts, :limit)

    case Keyword.take(opts, [:before, :after]) do
      [before: nil, after: nil] ->
        Repo.paginate(query, cursor_fields: [:inserted_at, :id], limit: limit)

      [before: nil, after: cursor_after] when is_binary(cursor_after) ->
        Repo.paginate(query, after: cursor_after, cursor_fields: [:inserted_at, :id], limit: limit)

      [after: nil, before: cursor_before] when is_binary(cursor_before) ->
        Repo.paginate(query,
          before: cursor_before,
          cursor_fields: [:inserted_at, :id],
          limit: limit
        )
    end
  end

  @doc """
  Creates an admin user.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %User{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_admin(map()) :: {:ok, User.t()} | {:error, Ecto.Changeset.t()}
  def create_admin(attrs) do
    %User{}
    |> User.admin_changeset(attrs)
    |> Repo.insert()
  end
end
