defmodule Erga.Staff.StakeholderRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stakeholder_roles" do
    field(:tag, :string)
    has_many(:stakeholders, Erga.Research.Stakeholder)
    timestamps()
  end

  @doc false
  def changeset(stakeholder_role, attrs) do
    stakeholder_role
    |> cast(attrs, [:tag])
    |> validate_required([:tag])
    |> unique_constraint(:tag)
    |> cast_assoc(:stakeholders)
  end
end
