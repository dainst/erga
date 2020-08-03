defmodule Erga.Repo.Migrations.FixLinkedResourceFieldTypes do
  use Ecto.Migration

  def change do
    alter table(:linked_resources) do
      remove(:label)
      remove(:context)
      add(:label, :string)
      add(:context, :string)
    end
  end
end
