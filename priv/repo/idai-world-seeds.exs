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
alias Erga.Research.Project
alias Erga.Research.TranslatedContent

Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder
Erga.Repo.delete_all ExternalLink
Erga.Repo.delete_all LinkedResource
Erga.Repo.delete_all TranslatedContent

id = 1
#fotoarchivdaiberlin
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_berlin.jpg"
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
id=id+2

#daiorient
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_orient_department.jpg"
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
id=id+2

#fotokairo
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_cairo.jpg"
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
id=id+2

#damascusbranch
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_damascus.jpg"
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
id=id+2

#fotoistanbul
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_istanbul.jpg"
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
id=id+2

#fotomadrid
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_madrid.jpg"
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
id=id+2

#fotorom
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_rome.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Rome department"
})
id=id+2

#teheran_digital
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_teheran.jpg"
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
id=id+2

#athenDigital
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

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
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_athen_department.jpg"
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
id=id+2

#spacodices
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "spacodices",
    external_links: [
      %ExternalLink{
        label: "Spanish Codices",
        url: "https://arachne.dainst.org/project/spacodices"
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
      filename: "idai_archive_spanish_codices.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_spanish_codices.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The digital catalog of illuminated manuscripts of medieval Spain is based on an inventory of about 4,500 colored small image slides, located in the Madrid Department of the German Archaeological Institute (DAI)."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Spanish Codices"
})
id=id+2

#handzeichnungen
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "handzeichnungen",
    external_links: [
      %ExternalLink{
        label: "Rome Department: Historical drawings",
        url: "https://arachne.dainst.org/project/handzeichnungen"
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
      filename: "idai_archive_dai_1_antike_Zeichnung.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_dai_1_antike_Zeichnung.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Antiquity in drawings, maps and architectural surveys: primary documentary materials of the 19th and 20th century in the German Archaeological Institute at Rome."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Rome Department: Historical drawings"
})
id=id+2

#gelehrtenbriefe
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "gelehrtenbriefe",
    external_links: [
      %ExternalLink{
        label: "Rome Department: Correspondences",
        url: "https://arachne.dainst.org/project/gelehrtenbriefe"
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
      filename: "idai_archive_dai_2_gelehrten.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_dai_2_gelehrten.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The drawings, aquarelles, maps, cross-sections, etc. of the two collections show ancient buildings and objects that document sites and finds that have been changed or destroyed in the course of the last years."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Rome Department: Correspondences"
})
id=id+2

#gelehrtenbriefe_quarantaene
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "gelehrtenbriefe_quarantaene",
    external_links: [
      %ExternalLink{
        label: "Rome Department: Correspondences-Quarantine",
        url: "https://arachne.dainst.org/project/gelehrtenbriefe_quarantaene"
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
      filename: "idai_archive_dai_quarantine.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/projects/idai_archive_dai_quarantine.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Correspondence of Emil Braun and Eduard Gerhard during a cholera outbreak in 1836-1837"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Rome Department: Correspondences-Quarantine"
})
id=id+2

#emagines
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "emagines",
    external_links: [
      %ExternalLink{
        label: "Link to Glass negatives within the framework of Emagines",
        url: "https://arachne.dainst.org/project/emagines"
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
      filename: "idai_digitization_imagines.jpg",
      path: "priv/repo/idai_world_assets/images/content/how/idai_digitization_imagines.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Within the project titled Emagines, glass negatives are being digitized with a long-term strategy and made accessible worldwide via the web-based database Arachne that is operated by the German Archaeological Institute and the CoDArchLab."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Glass negatives within the framework of Emagines"
})
id=id+2

#rakob
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "rakob",
    external_links: [
      %ExternalLink{
        label: "External Link to Bequest of Friedrich Rakob",
        url: "https://arachne.dainst.org/project/rakob"
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
      filename: "idai_archive_rakob.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/Idai_archive_rakob.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Friedrich Rakob (1931-2007) was an architectural historian specialized in the architectural history of towns and cities in Northern Tunisia. Friedrich Rakob’s bequest includes a total of more than 63,000 photographic negatives, slides and contact prints as well as around 190 crates and folders."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Bequest of Friedrich Rakob"
})
id=id+2

#hinkel
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "hinkel",
    external_links: [
      %ExternalLink{
        label: "External Link to Hinkel Archive of Sudan",
        url: "https://arachne.dainst.org/project/hinkel"
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
      filename: "idai_archive_cooperation_partner_hinkel.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_cooperation_partner_hinkel.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The archive of Friedrich W. Hinkel represents one of the largest collections of research material concerning the archaeology of ancient Sudan."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Friedrich Hinkel Archive of Sudan"
})
id=id+2

#kossack
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "kossack",
    external_links: [
      %ExternalLink{
        label: "External Link to Scientific Legacy of Georg Kossack",
        url: "https://arachne.dainst.org/project/kossack"
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
      filename: "idai_archive_cooperation_partner_kossack.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_cooperation_partner_kossack.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The integration of the archaeological material collection from the Kossack archive into existing datasets within the Arachne system allows a bidirectional connection between Kossack and the already existing data in Arachne."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Scientific Legacy of Georg Kossack"
})
id=id+2