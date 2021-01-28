defmodule Erga.Staff.Stakeholder do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholders" do
    field :first_name, :string
    field :last_name, :string
    field :title, :string, default: ""
    field :orc_id, :string
    field :organization_name, :string
    field :ror_id, :string

    has_many(:stakeholder_to_projects, Erga.Research.ProjectToStakeholder)

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [
      :first_name, :last_name, :title, :orc_id, :organization_name, :ror_id
      ])
    # |> validate_required([:first_name, :last_name])
    # TODO: Ensure organization_name+id or first_name+last_name+orc_id are set
    |> cast_assoc(:stakeholder_to_projects)
  end
end
