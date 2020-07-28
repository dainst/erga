defmodule Erga.Repo.Migrations.CreateTranslatedContents do
  use Ecto.Migration

  def change do
    create table(:translated_contents) do
      add :language_code, :string
      add :content, :text

      timestamps()
    end

  end
end
