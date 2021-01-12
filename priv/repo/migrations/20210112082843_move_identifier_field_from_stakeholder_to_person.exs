defmodule Erga.Repo.Migrations.MoveIdentifierFieldFromStakeholderToPerson do
  use Ecto.Migration

  def change do
    alter table(:stakeholders) do
      remove(:external_id)
      modify :project_id, :integer, null: false
    end

    alter table(:persons) do
      add(:external_id, :string)
    end
  end
end
