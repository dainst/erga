defmodule Erga.Repo.Migrations.CreateReferences do
  use Ecto.Migration

  def change do
    alter table(:linked_resources) do
      remove(:project_id)
      add(:project_id, references(:projects, on_delete: :delete_all, null: false))
    end

    alter table(:stakeholders) do
      remove(:project_id)
      add(:project_id, references(:projects, on_delete: :delete_all, null: false))
    end

    alter table(:images) do
      remove(:project_id)
      add(:project_id, references(:projects, on_delete: :delete_all, null: false))
    end
  end
end
