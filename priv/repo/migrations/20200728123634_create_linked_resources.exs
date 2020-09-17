defmodule Erga.Repo.Migrations.CreateLinkedResources do
  use Ecto.Migration

  def change do
    create table(:linked_resources) do
      add :project_id, :integer
      add :linked_system, :string
      add :linked_id, :string
      add :label, :integer
      add :description, :integer

      timestamps()
    end

  end
end
