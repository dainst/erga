defmodule ErgaWeb.Api.ProjectViewTest do
  use ErgaWeb.ConnCase, async: true

  alias Erga.Staff.Person

  alias Erga.Research.Project
  alias Erga.Research.TranslatedContent
  alias Erga.Research.Stakeholder
  alias Erga.Research.LinkedResource
  alias Erga.Research.Image

  alias ErgaWeb.Api.ProjectView

  def create_project(_) do
    p1 = %Person{
      id: 1,
      firstname: "Theodor",
      lastname: "Wiegand",
      title: "Prof. Dr."
    }

    p2 = %Person{
      id: 2,
      firstname: "Hansi",
      lastname: "Flick",
      title: "Cand. phil"
    }

    project =
      %Project{
        project_code: "SPP2143",
        starts_at: ~D[2019-01-10],
        ends_at: ~D[2023-10-10],
        title_translation_target_id: 1,
        description_translation_target_id: 2,
        titles: [
          %TranslatedContent{
            target_id: 1,
            language_code: "en",
            text: "Great digging project"
          }, %TranslatedContent{
            target_id: 1,
            language_code: "de",
            text: "Großartiges Ausgrabungsprojekt"
          }
        ],
        descriptions: [
          %TranslatedContent{
            target_id: 2,
            language_code: "de",
            text: "Eine sehr informative Projektbeschreibung."
          }, %TranslatedContent{
            target_id: 2,
            language_code: "en",
            text: "This is a very informativ project description."
          }
        ],
        stakeholders: [
          %Stakeholder{
            role: "chef role",
            external_id: "DOI:123XABC123",
            person_id: p1.id,
            person: p1
        },
          %Stakeholder{
            role: "intern",
            external_id: "PERSID:34578",
            person_id: p2.id,
            person: p2
          }],
        linked_resources: [
          %LinkedResource{
            label: "Rom",
            description: "Der Ort über den geschrieben wird.",
            uri: "https://gazetteer.dainst.org/doc/2078206",
            linked_system: "Gazetteer"
          }
        ],
        images: [
          %Image{
            label: "Test",
            primary: "true",
            path: "non-existing-image.jpg"
          }
        ]
    }

    %{project: project}
  end


  describe "render projects"  do
    setup [:create_project]

    test "render a project", params do
      response = ProjectView.render("project.json", params)
      # test if it can be parsed as json
      assert {:ok, _parsed_json} = Jason.encode(response)
    end

    test "render a project, short version", param do
      response = ProjectView.render("project_short.json", param)
      # test if it can be parsed as json
      assert {:ok, _parsed_json} = Jason.encode(response)
    end

    test "render list of projects", %{project: project} do
      response = ProjectView.render("list.json", %{projects: [project]})
      # test if it can be parsed as json
      assert {:ok, _parsed_json} = Jason.encode(response)
    end

  end

end
