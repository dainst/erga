defmodule Erga.Repo.Migrations.TranslatedContentToTargetMapping do
  use Ecto.Migration

  def change do

    alter table(:projects) do
      add(:title_translation_target_id, :integer)
      add(:description_translation_target_id, :integer)
    end

    alter table(:translated_contents) do
      remove(:content)
      add(:text, :text)
      add(:target_id, :integer)
    end

    drop table(:project_translations)

    create index(:translated_contents, [:target_id])
  end
end
