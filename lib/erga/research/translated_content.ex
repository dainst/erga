defmodule Erga.Research.TranslatedContent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "translated_contents" do
    field :text, :string
    field :language_code, :string
    has_one :target_assoc, Erga.Research.TranslationToTarget
    timestamps()
  end

  @doc false
  def changeset(translated_content, attrs) do
    translated_content
    |> cast(attrs, [:language_code, :text])
    |> validate_required([:language_code, :text])
  end
end
