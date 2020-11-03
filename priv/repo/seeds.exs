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

alias Erga.Research.ExternalLink
alias Erga.Research.LinkedResource
alias Erga.Research.Stakeholder
alias Erga.Staff.Person
alias Erga.Research.Project
alias Erga.Accounts.User
alias Erga.Research.TranslatedContent
alias Erga.Research.ProjectTranslation

Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder
Erga.Repo.delete_all ExternalLink
Erga.Repo.delete_all LinkedResource

Erga.Repo.insert!(%User{
  email: "admin",
  password_hash: Pow.Ecto.Schema.Password.pbkdf2_hash("erga123!")
})

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

Erga.Repo.insert!(%TranslatedContent{
  language_code: "DE",
  content: "Eine sehr informative Projektbeschreibung."
})

Erga.Repo.insert!(%TranslatedContent{
  language_code: "EN",
  content: "This is a very informativ project description."
})

Erga.Repo.insert!(%TranslatedContent{
  language_code: "DE",
  content: "Großartiges Ausgrabungsprojekt"
})

Erga.Repo.insert!(%TranslatedContent{
  language_code: "EN",
  content: "Great digging project"
})

Erga.Repo.insert! %Project{

  project_code: "SPP2143",
  starts_at: ~D[2019-01-10],
  ends_at: ~D[2023-10-10],

  stakeholders: [
    %Stakeholder{
      role: "chef role",
      external_id: "DOI:123XABC123",
      person_id: 1
  },
    %Stakeholder{
      role: "intern",
      external_id: "PERSID:34578",
      person_id: 2
    }],
  linked_resources: [
    %LinkedResource{
      label: "Rom",
      description: "Der Ort über den geschrieben wird.",
      linked_id: "2078206",
      linked_system: "Gazetteer"
    }
  ]
}

Erga.Repo.insert!(%ProjectTranslation{
  project_id: 1,
  translated_content_id: 1,
  col_name: "descr"
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: 1,
  translated_content_id: 2,
  col_name: "descr"
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: 1,
  translated_content_id: 3,
  col_name: "title"
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: 1,
  translated_content_id: 4,
  col_name: "title"
})
