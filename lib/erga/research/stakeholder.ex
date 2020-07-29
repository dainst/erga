defmodule Erga.Research.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field(:label, :string)

    field(:role, :string)
    field(:type, :string)
    field(:external_id, :string)

    belongs_to(:project, Erga.Research.Project)

    timestamps()
  end

  @doc false
  def changeset(stakeholder, attrs) do
    stakeholder
    |> cast(attrs, [:external_id, :label, :role, :type])
    |> validate_required([:external_id, :label, :role, :type])
    |> cast_assoc(:project)
  end
end
