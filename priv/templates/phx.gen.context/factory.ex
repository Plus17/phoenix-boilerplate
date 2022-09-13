

defmodule <%= inspect context.base_module %>.<%= inspect schema.alias %>Factory do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `<%= inspect schema.alias %>` context.
  """

  alias <%= inspect schema.module %>
end
