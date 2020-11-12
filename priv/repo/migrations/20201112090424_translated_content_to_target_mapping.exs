defmodule Erga.Repo.Migrations.TranslatedContentToTargetMapping do
  use Ecto.Migration

  def change do
    create table(:translated_contents_to_targets) do
      add(:target_id, :integer)
      add(:translated_content_id, references(:translated_contents))
      timestamps()
    end

    create index(:translated_contents_to_targets, [:target_id])
    create index(:translated_contents_to_targets, [:translated_content_id])
    create index(:translated_contents_to_targets, [:target_id, :translated_content_id], unique: true)

    alter table(:projects) do
      add(:title_id, :integer)
      add(:description_id, :integer)
    end

    alter table(:translated_contents) do
      remove(:content)
      add(:text, :text)
    end
  end
end
