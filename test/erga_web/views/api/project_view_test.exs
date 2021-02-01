defmodule ErgaWeb.Api.ProjectViewTest do
  use ErgaWeb.ConnCase, async: true

  alias Erga.Staff.Stakeholder
  alias Erga.Staff.StakeholderRole

  alias Erga.Research.Project
  alias Erga.Research.TranslatedContent
  alias Erga.Research.ProjectToStakeholder
  alias Erga.Research.LinkedResource
  alias Erga.Research.Image
  alias Erga.Research.ExternalLink

  alias ErgaWeb.Api.ProjectView

  def create_project(_) do
    p1 = %Stakeholder{
      id: 1,
      first_name: "Theodor",
      last_name: "Wiegand",
      title: "Prof. Dr.",
      orc_id: "some orc id",
      organization_name: "some organization name",
      ror_id: "some ror id"
    }

    p2 = %Stakeholder{
      id: 2,
      first_name: "Hansi",
      last_name: "Flick",
      title: "Cand. phil",
      orc_id: "another orc id",
      organization_name: "some organization name",
      ror_id: "some ror id"
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
        project_to_stakeholders: [
          %ProjectToStakeholder{
            stakeholder_role: %StakeholderRole{tag: "manager"},
            stakeholder: p1
        },
          %ProjectToStakeholder{
            stakeholder_role: %StakeholderRole{tag: "intern"},
            stakeholder: p2
          }],
        linked_resources: [
          %LinkedResource{
            labels: [
              %TranslatedContent{
                target_id: 3,
                language_code: "en",
                text: "Rom"
              }
            ],
            descriptions: [
              %TranslatedContent{
                target_id: 4,
                language_code: "de",
                text: "Der Ort über den geschrieben wird."
              },
              %TranslatedContent{
                target_id: 4,
                language_code: "en",
                text: "The place that is been written about."
              }
            ],
            uri: "https://gazetteer.dainst.org/place/2078206",
            linked_system: "gazetteer"
          },
          %LinkedResource{
            labels: [
              %TranslatedContent{
                target_id: 3,
                language_code: "en",
                text: "Berlin"
              }
            ],
            descriptions: [
              %TranslatedContent{
                target_id: 4,
                language_code: "de",
                text: "Der Ort an dem geschrieben wird."
              }
            ],
            uri: "https://gazetteer.dainst.org/place/2282601",
            linked_system: "gazetteer"
          }
        ],
        images: [
          %Image{
            labels: [
              %TranslatedContent{
                target_id: 5,
                language_code: "en",
                text: "Test"
              }
            ],
            primary: "true",
            path: "non-existing-image.jpg"
          }
        ],
        external_links: [
          %ExternalLink{
            labels: [
              %TranslatedContent{
                target_id: 6,
                language_code: "de",
                text: "Die Suchmaschine"
              }
            ],
            url: "https://www.google.com",
          }
        ],
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
