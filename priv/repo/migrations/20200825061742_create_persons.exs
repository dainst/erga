defmodule Erga.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :first_name, :string
      add :last_name, :string
      add :title, :string

      timestamps()
    end

  end
end
