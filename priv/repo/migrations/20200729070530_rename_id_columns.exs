defmodule Erga.Repo.Migrations.RenameProjectIdToKey do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      remove(:project_id)
      add(:project_code, :string)
    end

    alter table(:stakeholders) do
      remove(:stakeholder_id)
      add(:external_id, :string)
    end
  end
end
