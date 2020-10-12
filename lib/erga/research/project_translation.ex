defmodule Erga.Research.ProjectTranslation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Erga.Research.Project
  alias Erga.Research.TranslatedContent

  schema "project_translations" do
    belongs_to(:project, Project)
    belongs_to(:translated_content, TranslatedContent)
    field(:col_name, :string)
    timestamps()
  end

  @doc false
  def changeset(project_translation, attrs) do
    project_translation
    |> cast(attrs, [])
    |> validate_required([])
  end
end
