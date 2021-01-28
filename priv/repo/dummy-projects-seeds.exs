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
alias Erga.Staff.StakeholderRole
alias Erga.Research.Project
alias Erga.Research.Stakeholder
alias Erga.Research.TranslatedContent

Erga.Repo.delete_all ExternalLink
Erga.Repo.delete_all Image
Erga.Repo.delete_all LinkedResource
Erga.Repo.delete_all Person
Erga.Repo.delete_all StakeholderRole
Erga.Repo.delete_all Project
Erga.Repo.delete_all Stakeholder
Erga.Repo.delete_all TranslatedContent


p1 = Erga.Repo.insert!(%Person{
  firstname: "Theodor",
  lastname: "Wiegand",
  title: "Prof. Dr.",
  external_id: "http://viaf.org/viaf/12347811"
})

p2 = Erga.Repo.insert!(%Person{
  firstname: "Hansi",
  lastname: "Flick",
  external_id: "http://viaf.org/viaf/6918159820920814000000"
})

stakeholder_role_1 = Erga.Repo.insert!(%StakeholderRole{
  tag: "manager"
})

stakeholder_role_2 = Erga.Repo.insert!(%StakeholderRole{
  tag: "intern"
})

linked_place =
  %LinkedResource{
    description_translation_target_id: 3,
    label_translation_target_id: 4,
    uri: "https://gazetteer.dainst.org/place/2323295",
    linked_system: "gazetteer"
  }

linked_place2 =
    %LinkedResource{
      description_translation_target_id: 10,
      label_translation_target_id: 9,
      uri: "https://gazetteer.dainst.org/place/2072406",
      linked_system: "gazetteer"
}

linked_date =
  %LinkedResource{
    label_translation_target_id: 6,
    description_translation_target_id: 5,
    uri: "https://chronontology.dainst.org/period/mSrGeypeMHjw",
    linked_system: "chronontology"
  }

linked_thesauri_term = %{
  uri: "http://thesauri.dainst.org/_ab3a94b2.html",
  linked_system: "thesaurus"
}

linked_arachne_object = %{
  uri: "http://arachne.dainst.org/entity/1140385",
  linked_system: "arachne"
}

ex_link =
  %ExternalLink{
    label_translation_target_id: 12,
    url: "https://antikewelt.de/2021/01/15/wieder-intakt-die-restaurierung-der-saeulen-der-casa-del-fauno-in-pompeji/",
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
        person_id: p1.id,
        stakeholder_role_id: stakeholder_role_1.id
    },
      %Stakeholder{
        person_id: p2.id,
        stakeholder_role_id: stakeholder_role_2.id
      }],
    linked_resources: [
      linked_place, linked_place2, linked_date, linked_thesauri_term, linked_arachne_object
    ],
    external_links: [
      ex_link
    ]
}




Erga.Repo.insert!(%TranslatedContent{
  target_id: ex_link.label_translation_target_id,
  language_code: "de",
  text: "Super link, Background Story, wie alles begann!"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: ex_link.label_translation_target_id,
  language_code: "en",
  text: "The prequel to the main story, with a sick hook!"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_date.description_translation_target_id,
  language_code: "de",
  text: "Der Zeit über die geschrieben wird."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_date.description_translation_target_id,
  language_code: "en",
  text: "The period written about."
})

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
  target_id: linked_place2.description_translation_target_id,
  language_code: "de",
  text: "Der Ort über den auch geschrieben wird."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place2.description_translation_target_id,
  language_code: "en",
  text: "The place also written about."
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

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place.label_translation_target_id,
  language_code: "en",
  text: "Rome"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place.label_translation_target_id,
  language_code: "de",
  text: "Rom"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place2.label_translation_target_id,
  language_code: "en",
  text: "Etruria"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_place2.label_translation_target_id,
  language_code: "de",
  text: "Etrurien"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_date.label_translation_target_id,
  language_code: "en",
  text: "Classic"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: linked_date.label_translation_target_id,
  language_code: "de",
  text: "Klassik"
})

project2 =
  Erga.Repo.insert! %Project{

    project_code: "Dummy",
    starts_at: ~D[2020-02-29],
    ends_at: ~D[2024-02-29],
    title_translation_target_id: 7,
    description_translation_target_id: 8,

    stakeholders: [
      %Stakeholder{
        stakeholder_role_id: stakeholder_role_2.id,
        person_id: p1.id
    },
      %Stakeholder{
        stakeholder_role_id: stakeholder_role_1.id,
        person_id: p2.id
      }],
}

Erga.Repo.insert!(%TranslatedContent{
  target_id: project2.description_translation_target_id,
  language_code: "de",
  text: "Eine kurze Projektbeschreibung."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project2.description_translation_target_id,
  language_code: "en",
  text: "A short project description."
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project2.title_translation_target_id,
  language_code: "de",
  text: "Normales Ausgrabungsprojekt"
})

Erga.Repo.insert!(%TranslatedContent{
  target_id: project2.title_translation_target_id,
  language_code: "en",
  text: "Standard project"
})

{:ok, image} = Erga.Research.create_image(
  %{
    primary: "true",
    label_translation_target_id: 11,
    project_id: project.id,
    upload: %{
      filename: "idai_archive_spanish_codices.jpg",
      path: "priv/repo/idai_world_assets/images/content/what/images/idai_images_photothek_berlin.jpg"
    }
  }
)

Erga.Research.create_translated_content(
  %{
    "target_table" => image.__meta__.source,
    "target_table_primary_key" => image.id,
    "target_id" => nil,
    "target_field" => "label_translation_target_id",
    "text" => "Voll das passende Bild.",
    "language_code" => "de"
  }
)

Erga.Research.create_translated_content(
  %{
    "target_table" => image.__meta__.source,
    "target_table_primary_key" => image.id,
    "target_id" => nil,
    "target_field" => "label_translation_target_id",
    "text" => "Just a very fitting picture.",
    "language_code" => "en"
  }
)
