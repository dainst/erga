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

#fotokairo
project =
  Erga.Repo.insert! %Project{

    project_code: "fotokairo",
    external_links: [
      %ExternalLink{
        label: "Cairo department",
        url: "https://arachne.dainst.org/project/fotokairo"
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
      filename: "idai_images_photothek_cairo.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_cairo.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The photo archive of the Cairo Department focuses on the documentation of the department's excavations in Egypt. The archive comprises ca. 240,000 medium format (b/w, color) photographs, slides and 35mm-b/w-pictures."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Cairo Department"
})


#damascusbranch
project =
  Erga.Repo.insert! %Project{

    project_code: "damascusbranch",
    external_links: [
      %ExternalLink{
        label: "Damascus Branch",
        url: "https://www.dainst.org/en/standort/-/organization-display/ZI9STUj61zKB/124822"
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
      filename: "idai_images_photothek_damascus.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_damascus.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The photo archive of the branch owns around 45,000 negatives and slides from DAI research projects as well as of several important ruins in Syria that were documented as a part of a photographic survey. More than 40,000 digital images are archived."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Damascus Branch"
})

#fotoistanbul
project =
  Erga.Repo.insert! %Project{

    project_code: "fotoistanbul",
    external_links: [
      %ExternalLink{
        label: "Istanbul department",
        url: "https://arachne.dainst.org/project/fotoistanbul"
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
      filename: "idai_images_photothek_istanbul.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_istanbul.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The photo archive is made up primarily of black-and-white photographs of Turkey, its population, architecture and archaeological artifacts. Its holdings consist of approx. 120,000 photos from the period 1880 - 2007, including 65,000 negative originals."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Istanbul department"
})

#fotomadrid
project =
  Erga.Repo.insert! %Project{

    project_code: "fotomadrid",
    external_links: [
      %ExternalLink{
        label: "Madrid Department",
        url: "https://arachne.dainst.org/project/fotomadrid"
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
      filename: "idai_images_photothek_madrid.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_madrid.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The archive holds ca. 50,500 photographs. It covers all archaeological art forms of the Iberian Peninsula from the beginning of time up to the Islamic period."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Madrid department"
})

#fotorom
project =
  Erga.Repo.insert! %Project{

    project_code: "fotorom",
    external_links: [
      %ExternalLink{
        label: "Rome Department",
        url: "https://arachne.dainst.org/project/fotorom"
      },
      %ExternalLink{
        label: "Sculpture Negatives of the DAI Rome",
        url: "https://arachne.dainst.org/project/skulpturnegdairom"
      },
      %ExternalLink{
        label: "Microfiches of the Rome Deparment",
        url: "https://arachne.dainst.org/project/fotoromcategories"
      },
      %ExternalLink{
        label: "Scholarly Bequest of Josef Röder",
        url: "https://arachne.dainst.org/project/nachlassroeder"
      },
      %ExternalLink{
        label: "Inventory Registers",
        url: "https://arachne.dainst.org/project/invbuecherrom"
      },
      %ExternalLink{
        label: "Image Grid",
        url: "https://arachne.dainst.org/project/imagegrid"
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
      filename: "idai_images_photothek_rome.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_rome.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Rome department"
})

#teheran_digital
project =
  Erga.Repo.insert! %Project{

    project_code: "teheran_digital",
    external_links: [
      %ExternalLink{
        label: "Teheran Branch",
        url: "https://arachne.dainst.org/project/teheran_digital"
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
      filename: "idai_images_photothek_teheran.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/images/idai_images_photothek_teheran.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The photo archive houses a large collection of photographs on Iranian archaeology and art history as well as documentation of excavation of the department in Bisutun, Bastam, Takht-i Suleiman, Zendan-i Suleiman and Firuzabad."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Teheran Branch"
})
#athenDigital
project =
  Erga.Repo.insert! %Project{

    project_code: "athenDigital",
    external_links: [
      %ExternalLink{
        label: "Athens Department",
        url: "https://arachne.dainst.org/project/athenDigital"
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
      filename: "idai_archive_athen_department.jpg",
      url: "https://github.com/dainst/idai-world/blob/master/src/assets/images/content/what/archives/idai_archive_athen_department.jpg?raw=true"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Studies on the history of archaeology as well as on the history of academic institutions, such as the DAI, have demonstrated the importance of archival research and investigation of primary source material."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Athens Department"
})