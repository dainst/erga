defmodule Erga.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :project_id, :integer
      add :label, :integer
      add :path, :string

      timestamps()
    end

  end
end
