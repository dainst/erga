defmodule Erga.Research.TranslatedContent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translated_contents" do
    field :content, :string
    field :language_code, :string
    has_one :project_assoc, Erga.Research.ProjectTranslation
    timestamps()
  end

  @doc false
  def changeset(translated_content, attrs) do
    translated_content
    |> cast(attrs, [:language_code, :content])
    |> validate_required([:language_code, :content])
  end
end
