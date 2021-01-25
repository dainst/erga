defmodule Erga.Repo.Migrations.CreateStakeholderRoles do
  use Ecto.Migration
  import Ecto.Query

  def up do

    role_values =
      from("stakeholders", select: [:id, :role])
      |> Erga.Repo.all()

    create table(:stakeholder_roles) do
      add :key, :string

      timestamps()
    end

    alter table(:stakeholders) do
      add(:stakeholder_role_id, references(:stakeholder_roles, null: false))
      remove(:role)
    end

    flush()

    role_values
    |> Enum.filter(fn value -> value.role != nil and value.role != "" end)
    |> Enum.each(fn value ->
      {1, [%{id: role_id}]}=
        Erga.Repo.insert_all(
          "stakeholder_roles",
          [[key: value.role, inserted_at: NaiveDateTime.utc_now(), updated_at: NaiveDateTime.utc_now()]],
          returning: [:id]
        )

      from("stakeholders",
        where: [id: ^value.id],
        update: [set: [stakeholder_role_id: ^role_id]]
      )
      |> Erga.Repo.update_all([])

    end)
  end

  def down do
    role_values =
      from("stakeholder_roles", select: [:id, :key])
      |> Erga.Repo.all()

    alter table(:stakeholders) do
      add(:role, :string)
    end

    flush()

    role_values
    |> Enum.each(fn value ->
      from("stakeholders",
        where: [stakeholder_role_id: ^value.id],
        update: [set: [role: ^value.key]]
      )
      |> Erga.Repo.update_all([])
    end)

    flush()

    alter table(:stakeholders) do
      remove(:stakeholder_role_id)
    end

    drop table(:stakeholder_roles)
  end

  # def change do

  #   create table(:stakeholder_roles) do
  #     add :key, :string

  #     timestamps()
  #   end

  #   alter table(:stakeholders) do
  #     add(:stakeholder_role_id, references(:stakeholder_roles, null: false))
  #     remove(:role)
  #   end

  #   create unique_index(:stakeholder_roles, [:key])
  # end
end
