defmodule Erga.Repo.Migrations.TranslatedLabels do
  use Ecto.Migration

  import Ecto.Query

  def change do
    alter table(:images) do
      remove(:label)
      add(:label_translation_target_id, :integer)
    end

    alter table(:linked_resources) do
      remove(:label)
      add(:label_translation_target_id, :integer)
    end

    alter table(:external_links) do
      remove(:label)
      add(:label_translation_target_id, :integer)
    end
  end

  def up do
    up_labels(:images)
    up_labels(:linked_resources)
    up_labels(:external_links)
  end

  def down do
    down_labels(:images)
    down_labels(:linked_resources)
    down_labels(:external_links)
  end

  defp up_labels(table) do
    existing_labels =
      from(entry in Atom.to_string(table), select: [:id, :label])
      |> Erga.Repo.all()

    alter table(table) do
      remove(:label)
      add(:label_translation_target_id, :integer)
    end

    flush()

    existing_labels
    |> Enum.filter(fn entry -> entry.label != nil and entry.label != "" end)
    |> Enum.map(&Erga.Research.create_translated_content(
      %{
        "target_table" => Atom.to_string(table),
        "target_table_primary_key" => &1.id,
        "target_field" => "label_translation_target_id",
        "text" => &1.label,
        "language_code" => "en"
      })
    )
  end

  defp down_labels(table) do
    existing_data =
      from(
        entry in Atom.to_string(table),
        join: tc in Erga.Research.TranslatedContent, on: entry.label_translation_target_id == tc.target_id,
        select: {entry.id, tc}
      )
      |> Erga.Repo.all()

    existing_data
    |> Enum.map(fn {id, tc} -> tc end)
    |> List.flatten()
    |> Enum.each(
      &Erga.Research.delete_translated_content(
        &1,
        %{"target_table" => Atom.to_string(table), "target_field" => "label_translation_target_id"}
      )
    )

    alter table(table) do
      remove(:label_translation_target_id)
      add(:label, :string)
    end

    flush()

    existing_data
    |> Enum.uniq_by(fn {id, _} -> id end)
    |> Enum.each(fn {table_entry_id, label} ->
      case label do
        nil -> {:ok}
        value ->
          from(entry in Atom.to_string(table),
            where: [id: ^table_entry_id],
            update: [set: [label: ^value.text]]
          )
          |> Erga.Repo.update_all([])
      end
    end)
  end
end
