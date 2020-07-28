defmodule Erga.Research.LinkedResource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linked_resources" do
    field :context, :integer
    field :label, :integer
    field :linked_id, :string
    field :linked_system, :string
    field :project_id, :integer

    timestamps()
  end

  @doc false
  def changeset(linked_resource, attrs) do
    linked_resource
    |> cast(attrs, [:project_id, :linked_system, :linked_id, :label, :context])
    |> validate_required([:project_id, :linked_system, :linked_id, :label, :context])
  end
end
