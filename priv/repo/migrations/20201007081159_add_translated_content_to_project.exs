defmodule Erga.Repo.Migrations.AddTranslatedContentToProject do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      remove(:title)
      remove(:description)
    end
  end
end
