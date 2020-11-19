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

#steindorff
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "steindorff",
    external_links: [
      %ExternalLink{
        label: "External Link to Scientific Legacy of Georg Steindorff",
        url: "https://arachne.dainst.org/project/steindorff"
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
      filename: "idai_archive_cooperation_partner_steinhoff.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_cooperation_partner_steinhoff.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Steindorff’s diaries and letters always deal with the political processes in Germany, besides scientific questions."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Scientific Legacy of Georg Steindorff"
})
id=id+2


#syrher
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "syrher",
    external_links: [
      %ExternalLink{
        label: "External Link to Syrian Heritage Archive Project",
        url: "https://arachne.dainst.org/project/syrher"
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
      filename: "idai_archive_dai_4_syrian.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_dai_4_syrian.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Implementation of a digital cultural heritage register for Syria in order to conserve cultural heritage in Syria, which is currently threatened by war."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Syrian Heritage Archive Project"
})
id=id+2

#nara
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "nara",
    external_links: [
      %ExternalLink{
        label: "External Link to North African Heritage Archive",
        url: "https://arachne.dainst.org/project/nara"
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
      filename: "idai_archives_NAHA.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archives_NAHA.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The aim of the ‘North African Research Archive’ (NARA) is to provide a platform for archaeological cultural heritage from North Africa, in particular the Maghreb states of Tunisia, Algeria, Libya and Morocco."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "North African Heritage Archive"
})
id=id+2

#afrarchcologne
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "afrarchcologne",
    external_links: [
      %ExternalLink{
        label: "External Link to African Archaeological Archive Cologne",
        url: "https://arachne.dainst.org/project/afrarchcologne"
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
      filename: "idai_archive_hosted_partners_1_aaa.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_hosted_partners_1_aaa.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The African Archaeology Archive Cologne (AAArC) has made it a priority to digitize the present archieve documents and to make them accessible through the object database ARACHNE."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "African Archaeological Archive Cologne"
})
id=id+2


#rwwa
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "rwwa",
    external_links: [
      %ExternalLink{
        label: "External Link to Archive of Rhine-Westphalian Economy",
        url: "https://arachne.dainst.org/project/rwwa"
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
      filename: "idai_archive_hosted_partners_2_rww.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_hosted_partners_2_rww.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The negatives of the archive are depicting people in their working environments, productions techniques, machines and products, as well as industrial architecture or factories."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Archive of Rhine-Westphalian Economy"
})
id=id+2

#oppenheim
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "oppenheim",
    external_links: [
      %ExternalLink{
        label: "External Link to the Collection of Max von Oppenheim",
        url: "https://arachne.dainst.org/project/oppenheim"
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
      filename: "idai_archive_cooperation_partner_oppenheim.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/archives/idai_archive_cooperation_partner_oppenheim.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Max Freiherr von Oppenheim (1860-1946) was always accompanied by professional photographers when on his travels.The result was a collection of 13,000 photos that captured the life and culture of a world gone by."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "The Photographic Collection of Max von Oppenheim"
})
id=id+2

#fotothekmuenchen
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "fotothekmuenchen",
    external_links: [
      %ExternalLink{
        label: "External Link to Munich Photo Library of the LMU",
        url: "https://arachne.dainst.org/project/fotothekmuenchen"
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
      filename: "idai_images_munich_lmu.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_munich_lmu.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Institute of Classical Archaeology in Munich is home to a vast collection of photographs. Starting in 2016, digitization of this collection has been underway, with the results made open to the public via the Arachne database."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Munich Photo Library of the LMU"
})
id=id+2


#pergaltarbrowser
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "fotothekmuenchen",
    external_links: [
      %ExternalLink{
        label: "External Link to Pergamon Altar browser: Pergamon Museum Berlin",
        url: "https://arachne.dainst.org/project/pergaltarbrowser"
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
      filename: "idai_objects_pergamon_altar_browser.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_pergamon_altar_browser.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The image browser of the Pergamon Altar combines photographic recording of the frieze with the implementation into the online database ARACHNE."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Pergamon Altar browser: Pergamon Museum Berlin"
})
id=id+2


#idaibookbrowser
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idaibookbrowser",
    external_links: [
      %ExternalLink{
        label: "External Link to iDAI.objects/Arachne",
        url: "https://arachne.dainst.org/project/idaibookbrowser"
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
      filename: "idai_idaiworldarchitecture_bookbrowser.jpg",
      path: "priv/repo/idai_world_assets/images/content/how/idai_idaiworldarchitecture_bookbrowser.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "As a part of ARACHNE, iDAI.books offers digital versions of books on classical studies published between the 16th and 19th century. Next to making the single book pages available to research in a broader sense as digital scans, they are also characterized and contextualized as well as digitally preserved."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "iDAI.objects/bookbrowser"
})
id=id+2

#traianssaeule
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "traianssaeule",
    external_links: [
      %ExternalLink{
        label: "External Link to Trajans Column browser",
        url: "https://arachne.dainst.org/project/traianssaeule"
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
      filename: "idai_objects_trajans_column.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_trajans_column.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "By using a dedicated image browser, the Column of Trajan can now be researched in detail. Trajan’s Column is also contextualized to the entire contents of the Arachne."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Trajans Column browser"
})
id=id+2

#arapacis
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "arapacis",
    external_links: [
      %ExternalLink{
        label: "External Link to Ara Pacis Browser",
        url: "https://arachne.dainst.org/project/arapacis"
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
      filename: "idai_objects_ara_pacis.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_ara_pacis.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Ara Pacis Browser gives the opportunity to browse all relief panels of the monument."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Ara Pacis Browser"
})
id=id+2

#geo-maps-984
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "geo-maps-984",
    external_links: [
      %ExternalLink{
        label: "External Link to Al Idrisi - Archaeological Atlas of Algeria and Tunisia",
        url: "https://geoserver.dainst.org/maps/984"
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
      filename: "idai_space_time_al_idrisi.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_al_idrisi.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Geoserver of Algeria and Tunisia that has been mapped within the project Al Idrisi as a combination of the Atlas archéologique de l'Algérie and the Atlas archéologique de la Tunesie."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Al Idrisi - Archaeological Atlas of Algeria and Tunisia"
})
id=id+2

#geo-maps-981
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "geo-maps-981",
    external_links: [
      %ExternalLink{
        label: "External Link to Lead Ingots from Shipwrecks (Bizerte)",
        url: "https://geoserver.dainst.org/maps/981"
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
      filename: "idai_space_time_lead_ingots.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_lead_ingots.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Geoserver showing lead ingots that come from shipwrecks from the western Mediterranean."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Lead Ingots from Shipwrecks (Bizerte)"
})
id=id+2

#palmyra-gis
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "palmyra-gis",
    external_links: [
      %ExternalLink{
        label: "External Link to Palmyra-GIS",
        url: "https://arachne.dainst.org/project/palmyra-gis"
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
      filename: "idai_space_time_palmyra_gis_video.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_palmyra_gis_video.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "With the application Palmyra-GIS and the corresponding 3D print of the terrain model of the ancient Syrian city of ruins Palmyra, researchers want to contribute to the protection of the world heritage from the war in Syria."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Palmyra-GIS"
})
id=id+2
