defmodule Erga.Repo.Migrations.CreateExternalLinks do
  use Ecto.Migration

  def change do
    create table(:external_links) do
      add :project_id, :integer
      add :label, :string
      add :url, :string

      timestamps()
    end

  end
end
