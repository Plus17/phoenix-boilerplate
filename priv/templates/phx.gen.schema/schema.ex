defmodule <%= inspect schema.module %> do
  @moduledoc """
   The <%= schema.table %> schema module.
  """
  use <%= inspect context.base_module %>.Schema
  import Ecto.Changeset
<%= if schema.prefix do %>
  @schema_prefix :<%= schema.prefix %>
<% end %>
  schema <%= inspect schema.table %> do
<%= Mix.Phoenix.Schema.format_fields_for_schema(schema) %>
<%= for {_, k, _, _} <- schema.assocs do %>    field <%= inspect k %>, <%= if schema.binary_id do %>:binary_id<% else %>:id<% end %>
<% end %>
    timestamps()
  end

  @required [<%= Enum.map_join(schema.attrs, ", ", &inspect(elem(&1, 0))) %>]
  @optional []

  @doc false
  def changeset(<%= schema.singular %>, attrs) do
    <%= schema.singular %>
    |> cast(attrs, @required ++ @optional)
    |> validate_required(@required)
<%= for k <- schema.uniques do %>    |> unique_constraint(<%= inspect k %>)
<% end %>  end
end
