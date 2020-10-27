defmodule Erga.Research.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:project_code, :string)

    has_many(:stakeholders, Erga.Research.Stakeholder)
    has_many(:linked_resources, Erga.Research.LinkedResource)
    has_many(:external_links, Erga.Research.ExternalLink)
    has_many(:images, Erga.Research.Image)
    many_to_many(:title, Erga.Research.TranslatedContent, join_through: Erga.Research.ProjectTranslation, join_where: [col_name: "title"])
    many_to_many(:description, Erga.Research.TranslatedContent, join_through: Erga.Research.ProjectTranslation, join_where: [col_name: "descr"])

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_code])
    |> validate_required([:project_code])
    |> cast_assoc(:stakeholders)
    |> cast_assoc(:linked_resources)
    |> cast_assoc(:external_links)
    |> cast_assoc(:images)
  end
end
