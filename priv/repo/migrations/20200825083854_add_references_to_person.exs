defmodule Erga.Repo.Migrations.AddReferencesToPerson do
  use Ecto.Migration

  def change do
    alter table(:stakeholders) do
      add(:person_id, references(:persons, on_delete: :delete_all, null: false))
    end
  end
end
