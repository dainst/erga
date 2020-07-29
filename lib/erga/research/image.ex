defmodule Erga.Research.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :label, :integer
    field :path, :string

    belongs_to :project, Erga.Research.Project 

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:label, :path])
    |> validate_required([:label, :path])
    |> cast_assoc(:project)
  end
end
