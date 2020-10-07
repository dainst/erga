defmodule Erga.Research.ProjectDescrTranslations do
  use Ecto.Schema
  import Ecto.Changeset

  schema "project_descr_translations" do
    belongs_to(:project, Project, primary_key: true)
    belongs_to(:translated_content, TranslatedContent, primary_key: true)
    timestamps()
  end

  @doc false
  def changeset(project_translations, attrs) do
    project_translations
    |> cast(attrs, [])
    |> validate_required([])
  end
end
