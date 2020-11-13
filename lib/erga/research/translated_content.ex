defmodule Erga.Research.TranslatedContent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translated_contents" do
    field :target_id, :integer
    field :text, :string
    field :language_code, :string
    timestamps()
  end

  @doc false
  def changeset(translated_content, attrs) do
    translated_content
    |> cast(attrs, [:language_code, :text, :target_id])
    |> validate_required([:language_code, :text, :target_id])
  end
end
