defmodule AppName.Repo.Migrations.AddSettingsFieldToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add(:settings, :map, default: %{})
    end
  end
end
