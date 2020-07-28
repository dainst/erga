defmodule Erga.Research.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :description, :string
    field :project_id, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:project_id, :title, :description])
    |> validate_required([:project_id, :title, :description])
  end
end
