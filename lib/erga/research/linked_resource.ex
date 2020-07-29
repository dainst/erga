defmodule Erga.Research.LinkedResource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linked_resources" do
    field :context, :integer
    field :label, :integer
    field :linked_id, :string
    field :linked_system, :string

    belongs_to :project, Erga.Research.Project

    timestamps()
  end

  @doc false
  def changeset(linked_resource, attrs) do
    linked_resource
    |> cast(attrs, [:linked_system, :linked_id, :label, :context])
    |> validate_required([:linked_system, :linked_id, :label, :context])
    |> cast_assoc(:project)
  end
end
