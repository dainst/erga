defmodule Erga.Research.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field(:label, :string)
    field(:path, :string)
    field(:primary, :boolean)

    belongs_to(:project, Erga.Research.Project)

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:label, :path, :primary])
    |> validate_required([:label, :path, :primary])
    |> cast_assoc(:project)
  end
end
