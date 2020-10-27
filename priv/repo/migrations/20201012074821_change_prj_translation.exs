defmodule Erga.Repo.Migrations.ChangePrjTranslation do
  use Ecto.Migration

  def change do
    create table(:project_translations) do
      add(:project_id, references(:projects))
      add(:translated_content_id, references(:translated_contents))
      add(:col_name, :string)
      timestamps()
    end

    create index(:project_translations, [:col_name])
    drop table(:project_descr_translations)
    drop table(:project_title_translations)
  end
end
