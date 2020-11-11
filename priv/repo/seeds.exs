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

p1 = Erga.Repo.insert!(%Person{
  firstname: "Theodor",
  lastname: "Wiegand",
  title: "Prof. Dr."
})

p2 = Erga.Repo.insert!(%Person{
  firstname: "Hansi",
  lastname: "Flick",
  title: "Cand. phil"
})

project =
  Erga.Repo.insert! %Project{

    project_code: "SPP2143",
    starts_at: ~D[2019-01-10],
    ends_at: ~D[2023-10-10],

    stakeholders: [
      %Stakeholder{
        role: "chef role",
        external_id: "DOI:123XABC123",
        person_id: p1.id
    },
      %Stakeholder{
        role: "intern",
        external_id: "PERSID:34578",
        person_id: p2.id
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

Erga.Research.create_image(
  %{
    "label" => "Test",
    "primary" => "true",
    "project_code" => project.project_code,
    "project_id" => project.id,
    "upload" => %{
      filename: "idai_archive_spanish_codices.jpg",
      url: "https://idai.world/assets/images/content/what/archives/idai_archive_spanish_codices.jpg"
    }
  }
)

content = Erga.Repo.insert!(%TranslatedContent{
  language_code: "de",
  content: "Eine sehr informative Projektbeschreibung."
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: project.id,
  translated_content_id: content.id,
  col_name: "descr"
})

content = Erga.Repo.insert!(%TranslatedContent{
  language_code: "en",
  content: "This is a very informativ project description."
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: project.id,
  translated_content_id: content.id,
  col_name: "descr"
})

content = Erga.Repo.insert!(%TranslatedContent{
  language_code: "DE",
  content: "Großartiges Ausgrabungsprojekt"
})


Erga.Repo.insert!(%ProjectTranslation{
  project_id: project.id,
  translated_content_id: content.id,
  col_name: "title"
})

content = Erga.Repo.insert!(%TranslatedContent{
  language_code: "EN",
  content: "Great digging project"
})

Erga.Repo.insert!(%ProjectTranslation{
  project_id: project.id,
  translated_content_id: content.id,
  col_name: "title"
})
