defmodule Erga.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :project_id, :string
      add :title, :string
      add :description, :text

      timestamps()
    end

  end
end
