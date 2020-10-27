defmodule Erga.Repo.Migrations.AddUniqueProjectCode do
  use Ecto.Migration

  def change do
    create unique_index(:projects, [:project_code])
  end
end
