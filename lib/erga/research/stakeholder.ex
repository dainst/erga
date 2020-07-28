defmodule Erga.Research.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :label, :string
    field :project_id, :integer
    field :role, :string
    field :stakeholder_id, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(stakeholder, attrs) do
    stakeholder
    |> cast(attrs, [:project_id, :stakeholder_id, :label, :role, :type])
    |> validate_required([:project_id, :stakeholder_id, :label, :role, :type])
  end
end
