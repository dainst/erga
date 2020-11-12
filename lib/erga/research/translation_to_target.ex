defmodule Erga.Research.TranslationToTarget do
  use Ecto.Schema
  import Ecto.Changeset
  # alias Erga.Research.Project
  alias Erga.Research.TranslatedContent

  schema "translated_contents_to_targets" do
    # belongs_to(:project, Project)
    field(:target_id, :integer)
    belongs_to(:translated_content, TranslatedContent)
    timestamps()
  end

  @doc false
  def changeset(project_translation, attrs) do
    project_translation
    |> cast(attrs, [:target_id, :translated_content_id])
    |> validate_required([:target_id, :translated_content_id])
  end
end
