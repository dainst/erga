defmodule Erga.Repo.Migrations.AdjustStakeholder do
  use Ecto.Migration

  def change do
    alter table(:stakeholders) do
      remove(:label)
    end
  end
end
