defmodule Erga.Research.ExternalLink do
  use Ecto.Schema
  import Ecto.Changeset

  schema "external_links" do
    field(:label, :string)
    field(:url, :string)

    belongs_to :project, Erga.Research.Project

    timestamps()
  end

  @doc false
  def changeset(external_link, attrs) do
    external_link
    |> cast(attrs, [:label, :url])
    |> validate_required([:label, :url])
    |> cast_assoc(:project)
  end
end
