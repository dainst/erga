defmodule Erga.Repo.Migrations.RemoveStakeholderType do
  use Ecto.Migration

  def change do
    alter table(:stakeholders) do
      remove(:type)
    end
  end
end
