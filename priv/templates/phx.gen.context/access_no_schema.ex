alias <%= inspect schema.module %>

@doc """
Returns the list of <%= schema.plural %>.
## Examples
    iex> list()
    [%<%= inspect schema.alias %>{}, ...]
"""
def list do
  raise "TODO"
end

@doc """
Gets a single <%= schema.singular %>.
Raises if the <%= schema.human_singular %> does not exist.
## Examples
    iex> get!(123)
    %<%= inspect schema.alias %>{}
"""
def get!(id), do: raise "TODO"

@doc """
Creates a <%= schema.singular %>.
## Examples
    iex> create(%{field: value})
    {:ok, %<%= inspect schema.alias %>{}}
    iex> create(%{field: bad_value})
    {:error, ...}
"""
def create(attrs \\ %{}) do
  raise "TODO"
end

@doc """
Updates a <%= schema.singular %>.
## Examples
    iex> update(<%= schema.singular %>, %{field: new_value})
    {:ok, %<%= inspect schema.alias %>{}}
    iex> update(<%= schema.singular %>, %{field: bad_value})
    {:error, ...}
"""
def update(%<%= inspect schema.alias %>{} = <%= schema.singular %>, attrs) do
  raise "TODO"
end

@doc """
Deletes a <%= inspect schema.alias %>.
## Examples
    iex> delete(<%= schema.singular %>)
    {:ok, %<%= inspect schema.alias %>{}}
    iex> delete(<%= schema.singular %>)
    {:error, ...}
"""
def delete(%<%= inspect schema.alias %>{} = <%= schema.singular %>) do
  raise "TODO"
end

@doc """
Returns a data structure for tracking <%= schema.singular %> changes.
## Examples
    iex> change(<%= schema.singular %>)
    %Todo{...}
"""
def change(%<%= inspect schema.alias %>{} = <%= schema.singular %>, _attrs \\ %{}) do
  raise "TODO"
end
