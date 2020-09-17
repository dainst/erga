defmodule Erga.Repo.Migrations.StringImageLabel do
  use Ecto.Migration

  def change do
    alter table(:images) do
      remove(:label)
      add(:label, :string)
    end
  end
end
