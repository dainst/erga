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

  defp generate_translation_target_id(%{data: %{target_id: target_id}} = translated_content) when target_id != nil  do
    translated_content
  end

  defp generate_translation_target_id(%{changes: %{target_id: target_id}} = translated_content) when target_id != nil  do
    translated_content
  end

  defp generate_translation_target_id(translated_content) do
    translated_content.data
    highest_target_id =
      case from(q in "translated_contents", where: not is_nil(q.target_id), select: q.target_id, order_by: [desc: q.target_id],  limit: 1)
      |> Repo.all()
      |> List.first do
        nil -> 0
        id -> id
      end

    translated_content
    |> Ecto.Changeset.put_change(:target_id, highest_target_id + 1)
    |> Ecto.Changeset.unique_constraint(:target_id)
  end

end
