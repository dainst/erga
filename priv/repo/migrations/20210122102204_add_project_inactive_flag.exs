defmodule Erga.Repo.Migrations.AddProjectInactiveFlag do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add(:inactive, :boolean, null: false, default: false)
    end
  end
end
