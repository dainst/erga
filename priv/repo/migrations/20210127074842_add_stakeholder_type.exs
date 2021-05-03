defmodule Erga.Repo.Migrations.StakeholderType do
  use Ecto.Migration


  def up do
    alter table(:stakeholders) do
      add(:type, :string)
    end
  end
  end