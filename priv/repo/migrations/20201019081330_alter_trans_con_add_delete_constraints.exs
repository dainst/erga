defmodule Erga.Repo.Migrations.AlterTransConAddDeleteConstraints do
  use Ecto.Migration

  def change do
    alter table(:project_translations) do
      modify(:project_id, references(:projects, on_delete: :delete_all), from: references(:projects) )
      modify(:translated_content_id, references(:translated_contents, on_delete: :delete_all), from: references(:translated_contents))
    end
  end
end
