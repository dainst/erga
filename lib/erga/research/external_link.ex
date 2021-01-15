defmodule Erga.Research.ExternalLink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "external_links" do
    field(:url, :string)

    belongs_to :project, Erga.Research.Project

    field(:label_translation_target_id, :integer)
    has_many(:labels, Erga.Research.TranslatedContent, foreign_key: :target_id, references: :label_translation_target_id)

    timestamps()
  end

  @doc false
  def changeset(external_link, attrs) do
    external_link
    |> cast(attrs, [:url])
    |> validate_required([:url])
    |> cast_assoc(:project)
    |> cast_assoc(:labels)
  end
end
