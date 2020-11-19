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

#geo-maps-4935
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "geo-maps-4935",
    external_links: [
      %ExternalLink{
        label: "External Link to Palmyra Digital Atlas",
        url: "https://geoserver.dainst.org/maps/4935"
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
      filename: "idai_space_time_palmyra_digital_atlas.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_palmyra_digital_atlas.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Geoserver of Palmyra showing known structures and topography. Compilation of the antique polygon and line features from the Mapset Topographia Palmyrena."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Palmyra Digital Atlas"
})
id=id+2

#geo-maps-980
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "geo-maps-980",
    external_links: [
      %ExternalLink{
        label: "Triphylia - Map of a Greek landscape",
        url: "https://geoserver.dainst.org/maps/980"
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
      filename: "idai_space_time_triphylia.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_triphylia.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Geoserver of the Greek landscape of Triphylia that shows soils, terrain, settlements, rivers, etc."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Triphylia - Map of a Greek landscape"
})
id=id+2

#oadict
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "oadict",
    external_links: [
      %ExternalLink{
        label: "Open Access Dictionary",
        url: "http://archwort.dainst.org/de/vocab/"
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
      filename: "idai_libraries_vocab.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/libraries/idai_libraries_vocab.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A comprehensive dictionary for archaeological terms that offers translations into the common languages in the field of archaeology."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Open Access Dictionary"
})
id=id+2

#roman_chronology
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "roman_chronology",
    external_links: [
      %ExternalLink{
        label: "Roman Chronology",
        url: "https://chronontology.dainst.org/search?q=*&fq=tags:%27roman_chronology%27"
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
      filename: "idai_space_time_roman_chronology.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_roman_chronology.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A web service that connects period terms to dating and all kinds of material objects, geodata and textual data."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Roman Chronology"
})
id=id+2

#ancient_egypt
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "ancient_egypt",
    external_links: [
      %ExternalLink{
        label: "Ancient Egyptian Chronology",
        url: "http://chronontology.dainst.org/search?q=*&fq=tags:%27ancient_egypt%27"
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
      filename: "idai_space_time_ancient_egypt_chronology.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_ancient_egypt_chronology.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A web service connecting ancient Egyptian period terms to actual dating."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Ancient Egyptian Chronology"
})
id=id+2

#bronze_age_europe
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "bronze_age_europe",
    external_links: [
      %ExternalLink{
        label: "European bronze age chronology",
        url: "http://chronontology.dainst.org/search?q=*&fq=tags:%27bronze_age_europe%27"
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
      filename: "idai_space_time_europ_bronzeage_chronology.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_europ_bronzeage_chronology.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A web service connecting period terms of the European Bronze Age to actual dating."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "European bronze age chronology"
})
id=id+2

#geological_time_scale
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "geological_time_scale",
    external_links: [
      %ExternalLink{
        label: "Geological time scale",
        url: "http://chronontology.dainst.org/search?q=*&fq=tags:%27geological_time_scale%27"
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
      filename: "idai_space_time_geological_timescale.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/space-and-time/idai_space_time_geological_timescale.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A web service connecting the geological time terms to actual dating."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Geological time scale"
})
id=id+2


#preussdenk
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "preussdenk",
    external_links: [
      %ExternalLink{
        label: "Arachne Link to PreussDenk",
        url: "https://arachne.dainst.org/project/preussdenk"
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
      filename: "idai_preussdenk.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/projects/idai_preussdenk.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A DFG-project that aimed at documenting all built heritage sites in Brandenburg/Berlin between 1860/70 and 1918."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Prussian Monuments in the Province of Brandenburg/Berlin"
})
id=id+2

#claracstart
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "claracstart",
    external_links: [
      %ExternalLink{
        label: "Arachne Link to Musée Clarac",
        url: "https://arachne.dainst.org/project/claracstart"
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
      filename: "idai_objects_clarac.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_clarac.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The exploration of ancient sculpture before the middle of the 19th century as portrayed in Clarac’s 'Musée de sculpture antique et moderne'."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Clarac, Musée du Sculpture"
})
id=id+2

#idai_thesauri_emil_braun
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idai_thesauri_emil_braun",
    external_links: [
      %ExternalLink{
        label: "1836 - Emil Braun and the first library catalog",
        url: "http://arachne.uni-koeln.de/item/buch/5376"
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
      filename: "idai_thesauri_emil_braun.jpg",
      path: "priv/repo/idai_world_assets/images/content/how/idai_thesauri_emil_braun.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A digitized viewer of Emil Braun’s first library catalog from 1836 that is available through Arachne."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "1836 - Emil Braun and the first library catalog"
})
id=id+2

#idai_objects_ocre
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idai_objects_ocre",
    external_links: [
      %ExternalLink{
        label: "Online Coins of the Roman Empire (contains AFE)",
        url: "http://numismatics.org/ocre/"
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
      filename: "idai_objects_ocre.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_ocre.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A tool designed to help in the identification, cataloging, and research of the rich and varied coinage of the Roman Empire. The project records every published type of Roman Imperial coinage from Augustus in 31 BC, until the death of Zeno in AD 491."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Online Coins of the Roman Empire (contains AFE)"
})
id=id+2

#idai_objects_afe
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idai_objects_afe",
    external_links: [
      %ExternalLink{
        label: "External Link to 'AFE (a part of OCRE)'",
        url: "http://afe.dainst.org/"
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
      filename: "idai_objects_afe.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_afe.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A joint project of Databases and Information Systems (DBIS) and the Römisch-Germanische Kommission (RGK) is investigating the logical integration of different coin find databases using ontologies."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "AFE (a part of OCRE)"
})
id=id+2

#rezeptionantike
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "rezeptionantike",
    external_links: [
      %ExternalLink{
        label: "External Link to reception of antiquity in a semantic network",
        url: "https://arachne.dainst.org/project/rezeptionantike"
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
      filename: "idai_libraries_reception_of_antiquities.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/libraries/idai_libraries_reception_of_antiquities.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A reconstruction and online publication of about 1700 prints, which appeared between 1500 and 1900."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "reception of antiquity in a semantic network"
})
id=id+2


#berlinsamml
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "berlinsamml",
    external_links: [
      %ExternalLink{
        label: "Plaster casts after greco-roman sculptures in Berlin",
        url: "https://arachne.dainst.org/project/berlinsamml"
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
      filename: "idai_objects_plaster_casts_berlin.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_berlin.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Every plaster cast in Berlin (from Freie Universität, Humboldt-Universität, and the Antikensammlung/State Museums of Berlin) representing an ancient object was systematically recorded and entered into ARACHNE."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Plaster Casts in Berlin"
})
id=id+2

#idai_libraries_historical_books
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idai_libraries_historical_books",
    external_links: [
      %ExternalLink{
        label: "Digital Facsimiles of Historical Books",
        url: "https://arachne.dainst.org/search?q=catalogPaths:107"
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
      filename: "idai_libraries_historical_books.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/libraries/idai_libraries_historical_books.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The database compiles digital reproductions of historic illuminations in books and their cover pages in order to make them accessible to research."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Digital Facsimiles of Historical Books"
})
id=id+2

#antiksammlberlin
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "antiksammlberlin",
    external_links: [
      %ExternalLink{
        label: "Sculptures in the Antikensammlung, Berlin",
        url: "https://arachne.dainst.org/project/antiksammlberlin"
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
      filename: "idai_objects_plaster_casts_antikensammlung.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_antikensammlung.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The complete catalog of sculptures in the Antikensammlung der Staatlichen Museen zu Berlin contains approximately 2,600 Greek, Cypriot, Etruscan, and Roman sculptures in stone, as well as several large bronzes."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Sculptures in the Antikensammlung, Berlin"
})
id=id+2

#sammlakakunst
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "sammlakakunst",
    external_links: [
      %ExternalLink{
        label: "Plaster Cast Collection, University Bonn",
        url: "https://arachne.dainst.org/project/sammlakakunst"
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
      filename: "idai_objects_plaster_casts_bonn.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_bonn.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The collection has been photographically documented and transferred into Arachne since 1998. That way the technical emphasis of the Archaeological Institutes of Cologne and Bonn can be brought closer together."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Plaster Cast Collection, University Bonn"
})
id=id+2

#museomaff
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "museomaff",
    external_links: [
      %ExternalLink{
        label: "Museo Maffeiano online-edition",
        url: "https://arachne.dainst.org/project/museomaff"
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
      filename: "idai_objects_museo_maffeiano.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_museo_maffeiano.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Maffei published a book illustrating and describing various monuments in his collection, which is well suited for database-supported online-facsimile-edition. This online- aims to reflect a scientifically based preparation of the state of research."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Museo Maffeiano online-edition"
})
id=id+2

#schlossfulda
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "schlossfulda",
    external_links: [
      %ExternalLink{
        label: "Schloss Fasanerie (Adolphseck) near Fulda",
        url: "https://arachne.dainst.org/project/schlossfulda"
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
      filename: "idai_objects_plaster_casts_fulda.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_fulda.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Among furniture, porcelain and paintings, Fasanerie Castle (Adolphseck) in Eichenzell near Fulda also features a collection of Greco-Roman sculpture, which was assembled by Landgrave Philipp of Hesse (1896-1980)."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Schloss Fasanerie (Adolphseck) near Fulda"
})
id=id+2

#gipsleipzigsamml
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "gipsleipzigsamml",
    external_links: [
      %ExternalLink{
        label: "Museum and Plaster Cast Collection, Leipzig",
        url: "https://arachne.dainst.org/project/gipsleipzigsamml"
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
      filename: "idai_objects_plaster_casts_leipzig.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_leipzig.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Museum of Antiquities of the Leipzig University is an archaeological teaching collection that contains plaster casts and originals of ancient art from the Mediterranean area."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Museum and Plaster Cast Collection, Leipzig"
})
id=id+2

#abguesseMuenchen
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "abguesseMuenchen",
    external_links: [
      %ExternalLink{
        label: "Plaster cast collection, Munich, LMU",
        url: "https://arachne.dainst.org/project/abguesseMuenchen"
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
      filename: "idai_objects_plaster_casts_munich.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_munich.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The collection consists of more than 2000 casts and reproductions of sculptures, reliefs and small objects from Greek and Roman antiquity from the 7th century BC to the 5th century AD. The focus lies on Hellenistic sculpture and Roman portraits."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Plaster cast collection, Munich, LMU"
})
id=id+2

#villaWolkonsky
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "villaWolkonsky",
    external_links: [
      %ExternalLink{
        label: "Villa Wolkonsky, antiquities collection, Rome",
        url: "https://arachne.dainst.org/project/villaWolkonsky"
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
      filename: "idai_objects_plaster_casts_villa_wolkonsky.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_villa_wolkonsky.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Villa Wolkonsky houses about 430 Roman antiquities collected from the beginning of the 19th-century. The Arachne collection contains the photographic documentation that was produced during the restoration project, some photographs from the historic collection."})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Villa Wolkonsky, antiquities collection, Rome"
})
id=id+2

#sammlsaarbr
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "sammlsaarbr",
    external_links: [
      %ExternalLink{
        label: "Plaster cast collection, University Saarbrücken",
        url: "https://arachne.dainst.org/project/sammlsaarbr"
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
      filename: "idai_objects_plaster_casts_saarbruecken.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_saarbruecken.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Institute of Classical Archaeology of the University of the Saarland possesses a small teaching collection containing originals of antiquities as well as plaster casts of ancient sculpture."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Plaster cast collection, University Saarbrücken"
})
id=id+2

#stendal
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "stendal",
    external_links: [
      %ExternalLink{
        label: "Collection of Winckelmann-Society and Museum, Stendal",
        url: "https://arachne.dainst.org/project/stendal"
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
      filename: "idai_objects_plaster_casts_winckelmann.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_winckelmann.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The inventory holds drawings, paintings, sculpture, antiques, coins and portrait medals as well as autographs and sketches. The integration of the collection into the online database ARACHNE is still ongoing."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Winckelmann-Society and Museum, Stendal"
})
id=id+2

#katalogskulpthess
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "katalogskulpthess",
    external_links: [
      %ExternalLink{
        label: "Archaeological Museum, Thessaloniki",
        url: "https://arachne.dainst.org/project/katalogskulpthess"
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
      filename: "idai_objects_plaster_casts_thessaloniki.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_plaster_casts_thessaloniki.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Archaeological Museum of Thessaloniki keeps sculptures dating from the Archaic to the late Imperial period and found mainly in the area from various regions of Macedonia and Thrace."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Archaeological Museum, Thessaloniki"
})
id=id+2

#corpusantsark
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "corpusantsark",
    external_links: [
      %ExternalLink{
        label: "Corpus of Ancient Sarcophagi",
        url: "https://arachne.dainst.org/project/corpusantsark"
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
      filename: "idai_objects_sarcopharg.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_sarcopharg.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The re-conception of the Corpus of Ancient Sarcophagi and from an IT point of view, assuming responsibility for backing up an online-presence of the material, which is to be as coherent as possible."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Corpus of Ancient Sarcophagi"
})
id=id+2

#cilopac
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "cilopac",
    external_links: [
      %ExternalLink{
        label: "Corpus Inscriptionum Latinarum (CIL)",
        url: "https://arachne.dainst.org/project/cilopac"
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
      filename: "idai_libraries_cil.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/libraries/idai_libraries_cil.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The Corpus Inscriptionum Latinarum (CIL) is a comprehensive collection of ancient Latin inscriptions from all corners of the Roman Empire."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Corpus Inscriptionum Latinarum (CIL)"
})
id=id+2

#corpusminmyk
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "corpusminmyk",
    external_links: [
      %ExternalLink{
        label: "Corpus of Minoan and Mycenaean Seals",
        url: "https://arachne.dainst.org/project/corpusminmyk"
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
      filename: "idai_objects_minoan_seals.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_minoan_seals.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The project’s aim is the scholarly publication of every preserved seal and clay cast from the Aegean Bronze Age. Most of the Corpus should be digitized, updated and available on the Internet for free before the project ends in 2011."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Corpus of Minoan and Mycenaean Seals"
})
id=id+2

#idai_objects_creb
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "idai_objects_creb",
    external_links: [
    ]
  }
Erga.Research.create_image(
  %{
    "label" => "1",
    "primary" => "true",
    "project_code" => project.project_code,
    "project_id" => project.id,
    "upload" => %{
      filename: "idai_objects_creb.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/objects/idai_objects_creb.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "In preparation"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Corpus of Roman Finds in the European Babaricum (CRFB)"
})
id=id+2

#faak16
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "faak16",
    external_links: [
      %ExternalLink{
        label: "FAAK 16: Paracas Archaeological Materials",
        url: "https://arachne.dainst.org/project/faak16"
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
      filename: "Kacheln_Publications_data_publications_faak16.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_faak16.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "The catalog provides data and images of archaeological finds and contexts which have been excavated since 1996 by the Nasca-Palpa Project."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "FAAK 16: Paracas Archaeological Materials"
})
id=id+2

#siracusa_citta_e_mura
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "siracusa_citta_e_mura",
    external_links: [
      %ExternalLink{
        label: "Siracusa - La città e le sue mura",
        url: "https://arachne.dainst.org/project/siracusa_citta_e_mura"
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
      filename: "Kacheln_Publications_data_publications_siracusa.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_siracusa.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Studies on the Sicilian city of Syracuse"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Siracusa - La città e le sue mura"
})
id=id+2

#inden1
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "inden1",
    external_links: [
      %ExternalLink{
        label: "Inden",
        url: "https://arachne.dainst.org/project/inden1"
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
      filename: "inden.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/inden.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A digital documentation of an excavation of the 1960s"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Inden"
})
id=id+2

#inden1
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "inden1",
    external_links: [
      %ExternalLink{
        label: "Inden",
        url: "https://arachne.dainst.org/project/inden1"
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
      filename: "inden.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/inden.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A digital documentation of an excavation of the 1960s"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Inden"
})
id=id+2

#antikeplastik
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "antikeplastik",
    external_links: [
      %ExternalLink{
        label: "Antike Plastik 5.0.://",
        url: "https://arachne.dainst.org/project/antikeplastik?lang=de"
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
      filename: "Kacheln_Publications_data_publications_antike_plastik_5.0.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_antike_plastik_5.0.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "Media of documentation in archaeology"
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Antike Plastik 5.0.://"
})
id=id+2

#hafen
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "hafen",
    external_links: [
      %ExternalLink{
        label: "Images and Imaginations of Roman Harbors",
        url: "https://arachne.dainst.org/project/hafen?lang=de"
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
      filename: "Kacheln_Publications_data_publications_roemische_hafenanlagen.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_roemische_hafenanlagen.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication regarding the documentation and contextualized analysis of depictions of Roman harbors using Arachne."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Images and Imaginations of Roman Harbors"
})
id=id+2

#basilaemil
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "basilaemil",
    external_links: [
      %ExternalLink{
        label: "The Basilica Aemilia on the Forum Romanum",
        url: "https://arachne.dainst.org/project/basilaemil"
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
      filename: "Kacheln_Publications_data_publications_basilika_aemilia.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_basilika_aemilia.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication on the Basilica Aemilia on the Forum Romanum as a focus of public life. A study of its remains, functions, and roles in Rome."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "The Basilica Aemilia on the Forum Romanum"
})
id=id+2

#wohnkulturOstia
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "wohnkulturOstia",
    external_links: [
      %ExternalLink{
        label: "Domestic Culture in Late Antique Ostia",
        url: "https://arachne.dainst.org/project/wohnkulturOstia"
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
      filename: "Kacheln_Publications_data_publications_ostia.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_ostia.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication on the well-preserved remains of residential houses in the port city of Ostia that allow insights into the relationship of continuity and transformation between Imperial times and Late Antiquity."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Domestic Culture in Late Antique Ostia"
})
id=id+2

#kanatha
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "kanatha",
    external_links: [
      %ExternalLink{
        label: "Sanctuaries in Kanatha",
        url: "https://arachne.dainst.org/project/kanatha"
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
      filename: "Kacheln_Publications_data_publications_kanathan.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_kanathan.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication on the Syrian city of Kanatha and its specific forms of sanctuaries in Hellenistic and Roman times and the coexistence of indigenous religions and the Roman state religion."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Sanctuaries in Kanatha"
})
id=id+2

#kanatha
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "kanatha",
    external_links: [
      %ExternalLink{
        label: "Sanctuaries in Kanatha",
        url: "https://arachne.dainst.org/project/kanatha"
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
      filename: "Kacheln_Publications_data_publications_kanathan.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_kanathan.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication on the Syrian city of Kanatha and its specific forms of sanctuaries in Hellenistic and Roman times and the coexistence of indigenous religions and the Roman state religion."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Sanctuaries in Kanatha"
})
id=id+2

#langwiss
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "langwiss",
    external_links: [
      %ExternalLink{
        label: "Figurative Reception of Greek Poets and Philosophers",
        url: "https://arachne.dainst.org/project/langwiss"
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
      filename: "Kacheln_Publications_data_publications_mit_wissen_geschmueckt.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_mit_wissen_geschmueckt.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.description_translation_target_id,
  language_code: "en",
  text: "A publication on a project that is researching the depictions of the discourse of Greek education by using different classes of material such as gems, cameos, lamps, reliefs."
})
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Figurative Reception of Greek Poets and Philosophers"
})
id=id+2

#palilia
project =
  Erga.Repo.insert! %Project{
    title_translation_target_id: id,
    description_translation_target_id: (id+1),

    project_code: "palilia",
    external_links: [
      %ExternalLink{
        label: "Palilia",
        url: "https://publications.dainst.org/books/index.php/dai/catalog/series/palilia"
      },
      %ExternalLink{
        label: "No. 26: Wall Paintings Campania",
        url: "https://arachne.dainst.org/project/palilia26"
      },
      %ExternalLink{
        label: "No. 25: Republican otium-villas Tivoli",
        url: "https://arachne.dainst.org/project/palilia25"
      },
      %ExternalLink{
        label: "No. 24: Basilica Aemilia",
        url: "https://arachne.dainst.org/project/lippsbasilica"
      },
      %ExternalLink{
        label: "No. 20: Military in Rome",
        url: "https://arachne.dainst.org/project/palilia20"
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
      filename: "Kacheln_Publications_data_publications_palilia.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/publications/Kacheln_Publications_data_publications_palilia.jpg"
    }
  }
)
Erga.Repo.insert!(%TranslatedContent{
  target_id: project.title_translation_target_id,
  language_code: "en",
  text: "Palilia"
})
id=id+2
