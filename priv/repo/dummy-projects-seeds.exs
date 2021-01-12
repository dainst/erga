# Script for populating the database. You can run it as:
#
#     mix run priv/repo/dummy-seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Erga.Repo.insert!(%Erga.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Erga.Research.ExternalLink
alias Erga.Research.Image
alias Erga.Research.LinkedResource
alias Erga.Staff.Person
alias Erga.Research.Project
alias Erga.Research.Stakeholder
alias Erga.Research.TranslatedContent

Erga.Repo.delete_all ExternalLink
Erga.Repo.delete_all Image
Erga.Repo.delete_all LinkedResource
Erga.Repo.delete_all Person
Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder
Erga.Repo.delete_all TranslatedContent


p1 = Erga.Repo.insert!(%Person{
  firstname: "Theodor",
  lastname: "Wiegand",
  title: "Prof. Dr.",
  external_id: "DOI:123XABC123"
})

p2 = Erga.Repo.insert!(%Person{
  firstname: "Hansi",
  lastname: "Flick",
  title: "Cand. phil",
  external_id: "PERSID:34578"
})

linked_place =
  %LinkedResource{
    label: "Rom",
    description_translation_target_id: 3,
    uri: "https://gazetteer.dainst.org/place/2323295",
    linked_system: "Gazetteer"
  }

project =
  Erga.Repo.insert! %Project{

    project_code: "SPP2143",
    starts_at: ~D[2019-01-10],
    ends_at: ~D[2023-10-10],
    title_translation_target_id: 1,
    description_translation_target_id: 2,

    stakeholders: [
      %Stakeholder{
        role: "chef role",
        person_id: p1.id
    },
      %Stakeholder{
        role: "intern",
        person_id: p2.id
      }],
    linked_resources: [
      linked_place
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

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place.description_translation_target_id,
  language_code: "de",
  text: "Der Ort über den geschrieben wird."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place.description_translation_target_id,
  language_code: "en",
  text: "The place written about."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "de",
  text: "Eine sehr informative Projektbeschreibung."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "This is a very informativ project description."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "de",
  text: "Großartiges Ausgrabungsprojekt"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Great digging project"
})
