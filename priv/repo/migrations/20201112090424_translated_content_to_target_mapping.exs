defmodule Erga.Repo.Migrations.TranslatedContentToTargetMapping do
  use Ecto.Migration

  def change do

    alter table(:projects) do
      add(:title_id, :integer)
      add(:description_id, :integer)
    end

    alter table(:translated_contents) do
      remove(:content)
      add(:text, :text)
      add(:target_id, :integer)
    end

    create index(:translated_contents, [:target_id])
  end
end
