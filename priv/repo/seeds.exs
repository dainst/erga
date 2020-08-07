# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Erga.Repo.insert!(%Erga.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Erga.Research.Stakeholder
alias Erga.Research.Project

Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder


Erga.Repo.insert! %Stakeholder{
  label: "test_stakeholder_label",
  role: "test_stakeholder_role",
  type: "test_stakeholder_type",
  external_id: "test_stakeholder_id_1"
}
Erga.Repo.insert! %Project{
  description: "test",
  project_code: "test_code",
  title: "test_title",
  stakeholders: [%Stakeholder{
    label: "test_label1",
    role: "test_role",
    type: "test_type",
    external_id: "test_id_1"
  },
    %Stakeholder{
      label: "test_label2",
      role: "test_role",
      type: "test_type",
      external_id: "test_id_2"
    }]
}