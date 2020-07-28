defmodule Erga.Repo.Migrations.CreateStakeholders do
  use Ecto.Migration

  def change do
    create table(:stakeholders) do
      add :project_id, :integer
      add :stakeholder_id, :string
      add :label, :string
      add :role, :string
      add :type, :string

      timestamps()
    end

  end
end
