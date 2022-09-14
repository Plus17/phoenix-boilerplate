defmodule AppName.Schemas.Users.Settings do
  @moduledoc """
  User settings schema
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :has_2fa, :boolean, default: false
  end

  @required_fields [:has_2fa]
  @optional_fields []

  @doc false
  @spec changeset(Settings.t(), map()) :: Ecto.Changeset.t()
  def changeset(settings, attrs) do
    settings
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
