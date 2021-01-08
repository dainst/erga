defmodule Erga.Repo.Migrations.TranslatedContentForLinkedResource do
  use Ecto.Migration

  alias Erga.Research.LinkedResource

  import Ecto.Query

  def up do
    existing_descriptions =
      from(l in "linked_resources", select: [:id, :description])
      |> Erga.Repo.all()

    alter table(:linked_resources) do
      remove(:description)
      add(:description_translation_target_id, :integer)
    end

    flush()

    existing_descriptions
    |> Enum.filter(fn l -> l.description != nil and l.description != "" end)
    |> Enum.map(&Erga.Research.create_translated_content(
      %{
        "target_table" => "linked_resources",
        "target_table_primary_key" => &1.id,
        "target_field" => "description_translation_target_id",
        "text" => &1.description,
        "language_code" => "en"
      })
    )
  end

  def down do
    existing_data =
      LinkedResource
      |> Erga.Repo.all()
      |> Erga.Repo.preload(:descriptions)

    existing_data
    |> Enum.map(fn l -> l.descriptions end)
    |> List.flatten()
    |> Enum.each(
      &Erga.Research.delete_translated_content(
        &1,
        %{"target_table" => "linked_resources", "target_field" => "description_translation_target_id"}
      )
    )

    alter table(:linked_resources) do
      remove(:description_translation_target_id)
      add(:description, :string)
    end

    flush()

    existing_data
    |> Enum.each(fn data ->
      first_description = List.first(data.descriptions).text

      case first_description do
        nil -> {:ok}
        value ->
          from(l in "linked_resources",
            where: [id: ^data.id],
            update: [set: [description: ^value]]
          )
          |> Erga.Repo.update_all([])
      end
    end)
  end
end
