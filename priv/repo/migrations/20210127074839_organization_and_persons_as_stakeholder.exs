defmodule Erga.Repo.Migrations.InstitutionsAndPersonsAsStakeholder do
  use Ecto.Migration

  def change do
    # Modify old stakeholders table to projects_to_stakeholders.
    drop constraint(:stakeholders, "stakeholders_pkey")
    drop constraint(:stakeholders, "stakeholders_person_id_fkey")
    drop constraint(:stakeholders, "stakeholders_stakeholder_role_id_fkey")
    drop constraint(:stakeholders, "stakeholders_project_id_fkey")

    rename table(:stakeholders), to: table(:projects_to_stakeholders)

    alter table(:projects_to_stakeholders) do
      modify :id, :bigint, primary_key: true # recreates the primary key constraint with the new name "projects_to_stakeholders_pkey"
      modify :project_id, references(:projects) # recreate the foreign key constraints with new name
      modify :person_id, references(:persons)   # .. ^-
      modify :stakeholder_role_id, references(:stakeholder_roles) # ^-
    end

    execute "ALTER SEQUENCE stakeholders_id_seq RENAME TO projects_to_stakeholders_id_seq;"

    flush()

    # Modify old persons table to stakeholders.
    drop constraint(:projects_to_stakeholders, "projects_to_stakeholders_person_id_fkey")
    drop constraint(:persons, "persons_pkey")

    rename table(:persons), :external_id, to: :orc_id
    rename table(:persons), :firstname, to: :first_name # renamed for consistency, two words separted by underscore
    rename table(:persons), :lastname, to: :last_name   # ^-
    rename table(:persons), to: table(:stakeholders)

    alter table(:stakeholders) do
      modify :id, :bigint, primary_key: true # recreates the primary key constraint with the new name "stakeholders_pkey"
      add(:organization_name, :string)
      add(:ror_id, :string)
    end

    execute "ALTER SEQUENCE persons_id_seq RENAME TO stakeholders_id_seq;"

    # Modify projects_to_stakeholders to correctly map to renamed persons (now stakeholders) table.
    rename table(:projects_to_stakeholders), :person_id, to: :stakeholder_id

    alter table(:projects_to_stakeholders) do
      modify :stakeholder_id, references(:stakeholders)  # recreate the foreign key constraints with new name
    end
  end
end
