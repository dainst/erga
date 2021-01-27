defmodule Erga.Research.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    belongs_to(:project, Erga.Research.Project)
    belongs_to(:person, Erga.Staff.Person)
    belongs_to(:stakeholder_role, Erga.Staff.StakeholderRole)

    timestamps()
  end

  @doc false
  def changeset(stakeholder, attrs) do
    stakeholder
    |> cast(attrs, [:person_id, :stakeholder_role_id, :project_id])
    |> validate_required([:project_id])
    |> cast_assoc(:project)
    |> cast_assoc(:person)
    |> cast_assoc(:stakeholder_role)
    |> assoc_constraint(:project) # evaluated on insert, makes sure the data referred project exists
    |> assoc_constraint(:person)
    |> assoc_constraint(:stakeholder_role)
  end
end
