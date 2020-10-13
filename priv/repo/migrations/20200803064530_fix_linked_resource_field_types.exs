defmodule Erga.Repo.Migrations.FixLinkedResourceFieldTypes do
  use Ecto.Migration

  def change do
    alter table(:linked_resources) do
      remove(:label)
      remove(:description)
      add(:label, :string)
      add(:description, :string)
    end
  end
end
