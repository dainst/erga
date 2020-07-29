defmodule Erga.Repo.Migrations.AddProjectStartAndEnd do
  use Ecto.Migration

  def change do
    alter table(:projects) do
      add(:start_date, :naive_datetime)
      add(:end_date, :naive_datetime)
    end

    alter table(:images) do
      add(:primary, :boolean)
    end
  end
end
