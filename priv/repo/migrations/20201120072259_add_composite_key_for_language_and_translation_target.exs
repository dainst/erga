defmodule Erga.Repo.Migrations.AddCompositeKeyForLanguageAndTranslationTarget do
  use Ecto.Migration

  def change do
    create unique_index(:translated_contents, [:target_id, :language_code], name: :one_translation_for_language_index)
  end
end
