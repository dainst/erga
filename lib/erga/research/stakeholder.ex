defmodule Erga.Research.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field(:role, :string)

    belongs_to(:project, Erga.Research.Project)
    belongs_to(:person, Erga.Staff.Person)

    timestamps()
  end

  @doc false
  def changeset(stakeholder, attrs) do
    stakeholder
    |> cast(attrs, [:role, :person_id, :project_id])
    |> validate_required([:project_id])
    |> cast_assoc(:project)
    |> cast_assoc(:person)
    |> assoc_constraint(:project) # evaluated on insert, makes sure the data referred project exists
    |> assoc_constraint(:person)
  end
end
