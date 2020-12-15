defmodule Erga.Research.LinkedResource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linked_resources" do
    field(:description, :string)
    field(:label, :string)
    field(:uri, :string)
    field(:linked_system, :string)

    belongs_to(:project, Erga.Research.Project)

    timestamps()
  end

  @doc false
  def changeset(linked_resource, attrs) do
    linked_resource
    |> cast(attrs, [:linked_system, :uri, :label, :description])
    |> cast_assoc(:project)
    |> validate_required([:linked_system, :uri, :label])
  end
end
