defmodule Erga.Research.ProjectToStakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects_to_stakeholders" do
    belongs_to(:project, Erga.Research.Project)
    belongs_to(:stakeholder, Erga.Staff.Stakeholder)
    belongs_to(:stakeholder_role, Erga.Staff.StakeholderRole)

    timestamps()
  end

  @doc false
  def changeset(project_to_stakeholder, attrs) do
    project_to_stakeholder
    |> cast(attrs, [:stakeholder_id, :stakeholder_role_id, :project_id])
    |> validate_required([:project_id])
    |> cast_assoc(:project)
    |> cast_assoc(:stakeholder)
    |> cast_assoc(:stakeholder_role)
    |> assoc_constraint(:project) # evaluated on insert, makes sure the data referred project exists
    |> assoc_constraint(:stakeholder)
    |> assoc_constraint(:stakeholder_role)
  end
end
