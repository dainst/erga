defmodule Erga.Research.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field(:description, :string)
    field(:project_code, :string)
    field(:title, :string)

    has_many(:stakeholders, Erga.Research.Stakeholder)
    has_many(:linked_resources, Erga.Research.LinkedResource)
    has_many(:images, Erga.Research.Image)

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_code, :title, :description])
    |> validate_required([:project_code, :title, :description])
    |> cast_assoc(:stakeholders)
    |> cast_assoc(:linked_resources)
    |> cast_assoc(:images)
  end
end
