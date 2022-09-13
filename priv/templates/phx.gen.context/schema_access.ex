
  alias <%= inspect schema.module %>

  @doc """
  Returns the list of <%= schema.plural %>.
  ## Examples
      iex> list()
      [%<%= inspect schema.alias %>{}, ...]
  """
  def list do
    Repo.all(<%= inspect schema.alias %>)
  end

  @doc """
  Gets a single <%= schema.singular %>.
  Raises `Ecto.NoResultsError` if the <%= schema.human_singular %> does not exist.
  ## Examples
      iex> get!(123)
      %<%= inspect schema.alias %>{}
      iex> get!(456)
      ** (Ecto.NoResultsError)
  """
  def get!(id), do: Repo.get!(<%= inspect schema.alias %>, id)

  @doc """
  Creates a <%= schema.singular %>.
  ## Examples
      iex> create(%{field: value})
      {:ok, %<%= inspect schema.alias %>{}}
      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create(attrs \\ %{}) do
    %<%= inspect schema.alias %>{}
    |> <%= inspect schema.alias %>.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a <%= schema.singular %>.
  ## Examples
      iex> update(<%= schema.singular %>, %{field: new_value})
      {:ok, %<%= inspect schema.alias %>{}}
      iex> update(<%= schema.singular %>, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs) do
    <%= schema.singular %>
    |> <%= inspect schema.alias %>.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a <%= schema.singular %>.
  ## Examples
      iex> delete(<%= schema.singular %>)
      {:ok, %<%= inspect schema.alias %>{}}
      iex> delete(<%= schema.singular %>)
      {:error, %Ecto.Changeset{}}
  """
  def delete(%<%= inspect schema.alias %>{} = <%= schema.singular %>) do
    Repo.delete(<%= schema.singular %>)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking <%= schema.singular %> changes.
  ## Examples
      iex> change(<%= schema.singular %>)
      %Ecto.Changeset{data: %<%= inspect schema.alias %>{}}
  """
  def change(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs \\ %{}) do
    <%= inspect schema.alias %>.changeset(<%= schema.singular %>, attrs)
  end
