defmodule <%= inspect context.module %> do
  @moduledoc """
  The <%= context.name %> Manager.
  """

  import Ecto.Query, warn: false
  alias <%= inspect schema.repo %>
end
