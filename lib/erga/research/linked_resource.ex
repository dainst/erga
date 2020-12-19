defmodule Erga.Research.LinkedResource do
  use Ecto.Schema
  import Ecto.Changeset

  schema "linked_resources" do
    field(:label, :string)
    field(:uri, :string)
    field(:linked_system, :string)

    belongs_to(:project, Erga.Research.Project)

    field(:description_translation_target_id, :integer)
    has_many(:descriptions, Erga.Research.TranslatedContent, foreign_key: :target_id, references: :description_translation_target_id)

    timestamps()
  end

  @doc false
  def changeset(linked_resource, attrs) do
    linked_resource
    |> cast(attrs, [:linked_system, :uri, :label])
    |> cast_assoc(:project)
    |> validate_required([:linked_system, :uri, :label])
  end
end
