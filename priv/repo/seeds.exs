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
alias Erga.Staff.Person
alias Erga.Research.Project

Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder

Erga.Repo.insert!(%Person{
  firstname: "Theodor",
  lastname: "Wiegand",
  title: "Prof. Dr."
})

Erga.Repo.insert!(%Person{
  firstname: "Hansi",
  lastname: "Flick",
  title: "Cand. phil"
})

Erga.Repo.insert! %Project{
  description: "This is a very informativ project description.",
  project_code: "1234_PROJ_DAI",
  title: "Great digging project",
  stakeholders: [%Stakeholder{
    role: "chef role",
    type: "what was type for?",
    external_id: "no clue what the external id was about",
    person_id: 1
  },
    %Stakeholder{
      role: "intern",
      type: "lazy",
      external_id: "not needed",
      person_id: 2
    }]
}
