defmodule Erga.Staff.StakeholderRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholder_roles" do
    field(:key, :string)
    has_many(:stakeholders, Erga.Research.Stakeholder)
    timestamps()
  end

  @doc false
  def changeset(stakeholder_role, attrs) do
    stakeholder_role
    |> cast(attrs, [:key])
    |> validate_required([:key])
    |> unique_constraint(:key)
    |> cast_assoc(:stakeholders)
  end
end
