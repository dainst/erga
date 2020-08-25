defmodule Erga.Person do
  use Ecto.Schema
  import Ecto.Changeset

  schema "persons" do
    field :firstname, :string
    field :lastname, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:firstname, :lastname, :title])
    |> validate_required([:firstname, :lastname, :title])
  end
end
