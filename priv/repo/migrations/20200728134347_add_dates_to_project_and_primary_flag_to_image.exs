defmodule Erga.Repo.Migrations.AddProjectStartAndEnd do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add(:starts_at, :date)
      add(:ends_at, :date)
    end

    alter table(:images) do
      add(:primary, :boolean)
    end
  end
end
