defmodule Erga.Research.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :label, :integer
    field :path, :string
    field :project_id, :integer

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:project_id, :label, :path])
    |> validate_required([:project_id, :label, :path])
  end
end
