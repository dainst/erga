defmodule Erga.Research.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:project_code, :string)
    field(:starts_at, :date)
    field(:ends_at, :date)
    has_many(:stakeholders, Erga.Research.Stakeholder)
    has_many(:linked_resources, Erga.Research.LinkedResource)
    has_many(:external_links, Erga.Research.ExternalLink)
    has_many(:images, Erga.Research.Image)

    field(:title_translation_target_id, :integer)
    field(:description_translation_target_id, :integer)
    has_many(:titles, Erga.Research.TranslatedContent, foreign_key: :target_id, references: :title_translation_target_id)
    has_many(:descriptions, Erga.Research.TranslatedContent, foreign_key: :target_id, references: :description_translation_target_id)

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_code, :starts_at, :ends_at])
    |> unique_constraint(:project_code)
    |> validate_required([:project_code])
    |> cast_assoc(:stakeholders)
    |> cast_assoc(:linked_resources)
    |> cast_assoc(:external_links)
    |> cast_assoc(:images)
  end
end
