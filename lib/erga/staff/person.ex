defmodule Erga.Staff.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "persons" do
    field :firstname, :string
    field :lastname, :string
    field :title, :string

    has_many(:stakeholders, Erga.Research.Stakeholder)

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:firstname, :lastname, :title])
    |> validate_required([:firstname, :lastname, :title])
    |> cast_assoc(:stakeholders)
  end
end
