defmodule Erga.Repo.Migrations.CreateProjectTitleTranslations do
  use Ecto.Migration

  def change do
    create table(:project_title_translations) do
      add(:project_id, references(:projects))
      add(:translated_content_id, references(:translated_contents))
      timestamps()
    end

    create(index(:project_title_translations, [:project_id]))
    create(index(:project_title_translations, [:translated_content_id]))

  end
end
