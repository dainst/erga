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

#fotoarchivdaiberlin
project =
  Erga.Repo.insert! %Project{

    project_code: "fotoarchivdaiberlin",
    external_links: [
      %ExternalLink{
        label: "Berlin head office",
        url: "https://arachne.dainst.org/project/fotoarchivdaiberlin"
      }
    ]
  }
Erga.Research.create_image(
  %{
    "label" => "1",
    "primary" => "true",
    "project_code" => project.project_code,
    "project_id" => project.id,
    "upload" => %{
      filename: "idai_images_photothek_berlin.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_berlin.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The photo archive at the Berlin head office offers images on vase painting, sculpture, lamps and topography. Among the scholarly bequests are those of Th. Wiegand, O. Reuther, F. Noack, B. Schweitzer, G. Loeschke, A. Schiff, K. Ronczewski.",
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Berlin Head Office"
})


#daiorient
project =
  Erga.Repo.insert! %Project{

    project_code: "daiorient",
    external_links: [
      %ExternalLink{
        label: "Berlin orient department",
        url: "https://arachne.dainst.org/project/daiorient"
      }
    ]
  }
Erga.Research.create_image(
  %{
    "label" => "1",
    "primary" => "true",
    "project_code" => project.project_code,
    "project_id" => project.id,
    "upload" => %{
      filename: "idai_images_photothek_orient_department.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_orient_department.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Since 1998, the focus of the photographic collection has been on the documentation of own excavations in countries such as Ethiopia, Iraq, Yemen, Jordan, Lebanon, Oman, Saudi Arabia, Syria and eastern Turkey.",
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Berlin Orient Department"
})
