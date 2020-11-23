defmodule Erga.Research.TranslatedContent do
  use Ecto.Schema

  alias Erga.Repo

  import Ecto.Changeset
  import Ecto.Query, warn: false

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
    |> generate_translation_target_id()
    |> validate_required([:language_code, :text, :target_id])
    |> unique_constraint(
        :only_one_translation_for_language,
        name: :one_translation_for_language_index,
        message: "There already exists a translation for this language."
      )
  end

  defp generate_translation_target_id(%{data: %{target_id: _target_id}} = translated_content) do
    translated_content
  end

  defp generate_translation_target_id(translated_content) do
    translated_content.data
    highest_target_id =
      from(q in "translated_contents", select: q.target_id, order_by: [desc: q.target_id],  limit: 1)
      |> Repo.all()
      |> List.first

    translated_content
    |> Ecto.Changeset.put_change(:target_id, highest_target_id + 1)
    |> Ecto.Changeset.unique_constraint(:target_id)
  end

end
