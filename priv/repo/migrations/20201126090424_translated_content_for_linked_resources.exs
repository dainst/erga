defmodule Erga.Repo.Migrations.TranslatedContentForLinkedResource do
  use Ecto.Migration

  def change do

    alter table(:linked_resources) do
      remove(:description)
      add(:description_translation_target_id, :integer)

    end
  end
end
