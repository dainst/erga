defmodule Erga.Repo.Migrations.CreatePersons do
  use Ecto.Migration

  def change do
    create table(:persons) do
      add :firstname, :string
      add :lastname, :string
      add :title, :string

      timestamps()
    end

  end
end
