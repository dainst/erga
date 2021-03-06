defmodule Erga.ResearchTest do
  use Erga.DataCase

  alias Erga.Research
  alias Erga.Staff
  alias NaiveDateTime

  setup do
    on_exit(fn -> File.rm_rf(Application.get_env(:erga, :uploads_directory)) end)
  end

  defp create_project(_) do
    {:ok, proj} = Research.create_project(%{
      project_code: "Test001",
      starts_at: ~D[2019-01-10],
      ends_at: ~D[2023-10-10],
      title_translation_target_id: 1,
    })
    %{project: proj}
  end

  defp create_stakeholder(_) do
    {:ok, pers} = Staff.create_stakeholder( %{
      first_name: "some first_name",
      last_name: "some last_name",
      title: "some title",
      orc_id: "https://orcid.org/0000-0000-0000-0000",
      organization_name: "some organization name",
      ror_id: "https://ror.org/023md1f53"
    })
    %{stakeholder: pers}
  end

  defp create_stakeholder_variant(_) do
    {:ok, pers} = Staff.create_stakeholder(
      %{first_name: "another first_name",
      last_name: "another last_name",
      title: "another title",
      orc_id: "https://orcid.org/0000-0000-0000-0001",
      organization_name: "another organization name",
      ror_id: "https://ror.org/023md1f54"
    })
    %{stakeholder_variant: pers}
  end

  defp create_stakeholder_role(_) do
    {:ok, role} =
      Staff.create_stakeholder_role(
        %{tag: "some stakeholder role"}
      )
    %{stakeholder_role: role}
  end

  defp create_stakeholder_role_variant(_) do
    {:ok, role} =
      Staff.create_stakeholder_role(
        %{tag: "some variant stakeholder role"}
      )
    %{stakeholder_role_variant: role}
  end

  describe "projects" do
    alias Erga.Research.Project

    @valid_attrs %{ project_code: "some project_id", starts_at: ~D[2019-01-10], ends_at: ~D[2023-10-10], title_translation_target_id: 1}
    @update_attrs %{ project_code: "some updated project_id", starts_at: ~D[2018-02-20], ends_at: ~D[2024-12-20],  title_translation_target_id: 1}
    @invalid_attrs %{description: nil, project_code: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_project()

      project
    end

    # see SD-867
    #
    test "list_projects/0 returns all projects" do
      project = project_fixture()
      [head | _tail] = Research.list_projects()
      assert head.project_code == project.project_code
      assert head.starts_at == project.starts_at
      assert head.ends_at == project.ends_at
      assert head.title_translation_target_id == project.title_translation_target_id
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      head = Research.get_project!(project.id)
      assert head.project_code == project.project_code
      assert head.starts_at == project.starts_at
      assert head.ends_at == project.ends_at
      assert head.title_translation_target_id == project.title_translation_target_id
    end

    test "get_projects_updated_since!/1 returns all requested projects" do
      date_since = NaiveDateTime.utc_now()
      project = project_fixture()
      [head | _tail] = Research.get_projects_updated_since(date_since)
      assert head.project_code == project.project_code
      assert head.starts_at == project.starts_at
      assert head.ends_at == project.ends_at
      assert head.title_translation_target_id == project.title_translation_target_id
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Research.create_project(@valid_attrs)
      assert project.project_code == "some project_id"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Research.update_project(project, @update_attrs)
      assert project.project_code == "some updated project_id"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_project(project, @invalid_attrs)
   #   assert project == Research.get_project!(project.id)
    end

    test "toggle_inactive/1 toggles the project status" do
      project = project_fixture()

      assert {:ok, %Project{inactive: true}} = Research.toggle_inactive(project)
      assert %Project{inactive: true} = project = Research.get_project!(project.id)

      assert {:ok, %Project{inactive: false}} = Research.toggle_inactive(project)
      assert %Project{inactive: false} = Research.get_project!(project.id)
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Research.change_project(project)
    end
  end

  describe "linked_resources" do
    alias Erga.Research.LinkedResource

    @proj_attrs %{
      project_code: "Test001",
      starts_at: ~D[2019-01-10],
      ends_at: ~D[2023-10-10],
      title_translation_target_id: 1,
    }
    @valid_attrs %{
      "linked_system" => "gazetteer",
      "uri" => "https://gazetteer.dainst.org/place/2282601",
      "descriptions" => []
    }
    @update_attrs %{
      "linked_system" => "gazetteer",
      "uri" => "https://gazetteer.dainst.org/place/2282602"
    }
    @invalid_attrs %{
      "uri" => nil
    }

    def linked_resource_fixture(_attrs \\ %{}) do
      {:ok, proj} = Research.create_project(@proj_attrs)
      {:ok, linked_resource} =
        %{"project_id" => proj.id}
        |> Enum.into(@valid_attrs)
        |> Research.create_linked_resource()

      Research.get_linked_resource!(linked_resource.id)
    end

    test "get_linked_resource!/1 returns the linked_resource with given id" do
      linked_resource = linked_resource_fixture()
      assert Research.get_linked_resource!(linked_resource.id) == linked_resource
    end

    test "create_linked_resource/1 with valid data creates a linked_resource" do
      {:ok, proj} = Research.create_project(@proj_attrs)
      assert {:ok, %LinkedResource{} = linked_resource} =
        %{"project_id" => proj.id}
        |> Enum.into(@valid_attrs)
        |> Research.create_linked_resource()

      assert linked_resource.linked_system == "gazetteer"
      assert linked_resource.uri == "https://gazetteer.dainst.org/place/2282601"
    end

    test "create_linked_resource/1 with invalid data returns error changeset" do
      {:ok, proj} = Research.create_project(@proj_attrs)
      assert {:error, %Ecto.Changeset{}} =
        %{"project_id" => proj.id}
        |> Enum.into(@invalid_attrs)
        |> Research.create_linked_resource()
    end

    test "update_linked_resource/2 with valid data updates the linked_resource" do
      linked_resource = linked_resource_fixture()
      assert {:ok, %LinkedResource{} = linked_resource} = Research.update_linked_resource(linked_resource, @update_attrs)

      assert linked_resource.linked_system == "gazetteer"
      assert linked_resource.uri == "https://gazetteer.dainst.org/place/2282602"
    end

    test "update_linked_resource/2 with invalid data returns error changeset" do
      linked_resource = linked_resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_linked_resource(linked_resource, @invalid_attrs)
      assert linked_resource == Research.get_linked_resource!(linked_resource.id)
    end

    test "delete_linked_resource/1 deletes the linked_resource" do
      Process.sleep(1000) #Needed for a change in date
      time = NaiveDateTime.utc_now()
      projects_before = Research.get_projects_updated_since(time)
      linked_resource = linked_resource_fixture()
      assert {:ok, %LinkedResource{}} = Research.delete_linked_resource(linked_resource)
      assert_raise Ecto.NoResultsError, fn -> Research.get_linked_resource!(linked_resource.id) end
      assert projects_before != Research.get_projects_updated_since(time)


    end

    test "change_linked_resource/1 returns a linked_resource changeset" do
      linked_resource = linked_resource_fixture()
      assert %Ecto.Changeset{} = Research.change_linked_resource(linked_resource)
    end
  end

  describe "project_to_stakeholders" do
    setup [
      :create_project,
      :create_stakeholder,
      :create_stakeholder_variant,
      :create_stakeholder_role,
      :create_stakeholder_role_variant
    ]

    alias Erga.Research.ProjectToStakeholder

    @valid_attrs %{"role" => "some role"}
    @update_attrs %{"role" => "some updated role"}
    @invalid_attrs %{"project_id" => nil}

    def project_to_stakeholder_fixture(attrs \\ %{}) do
      {:ok, project_to_stakeholder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_project_to_stakeholder()

      Research.get_project_to_stakeholder!(project_to_stakeholder.id)
    end

    test "get_project_to_stakeholder!/1 returns the project_to_stakeholder with given id", %{project: proj, stakeholder: pers} do
      project_to_stakeholder = project_to_stakeholder_fixture(%{"project_id" => proj.id, "stakeholder_id" => pers.id})
      assert Research.get_project_to_stakeholder!(project_to_stakeholder.id) == project_to_stakeholder
    end

    test "create_project_to_stakeholder/1 with valid data creates a project_to_stakeholder",
    %{
      project: proj,
      stakeholder: pers,
      stakeholder_role: role
    } do
      assert {:ok, %ProjectToStakeholder{} = project_to_stakeholder} =
        %{"project_id" => proj.id, "stakeholder_id" => pers.id, "stakeholder_role_id" => role.id}
        |> Enum.into(@valid_attrs)
        |> Research.create_project_to_stakeholder()

      project_to_stakeholder =
        project_to_stakeholder
        |> Repo.preload(:stakeholder_role)
        |> Repo.preload(:stakeholder)

      assert project_to_stakeholder.stakeholder.first_name == pers.first_name
      assert project_to_stakeholder.stakeholder.last_name == pers.last_name
      assert project_to_stakeholder.stakeholder.title == pers.title

      assert project_to_stakeholder.project_id == proj.id

      assert project_to_stakeholder.stakeholder_role.tag == role.tag
    end

    test "create_project_to_stakeholder/1 with invalid data returns error changeset", %{project: proj, stakeholder: pers}  do
      assert {:error, %Ecto.Changeset{}} =
        %{"project_id" => proj.id, "stakeholder_id" => pers.id}
        |> Map.merge(@invalid_attrs)
        |> Research.create_project_to_stakeholder()
    end

    test "update_project_to_stakeholder/2 with valid data updates the project_to_stakeholder",
    %{
      project: proj,
      stakeholder: stakeholder,
      stakeholder_variant: stakeholder_variant,
      stakeholder_role: role,
      stakeholder_role_variant: role_variant
    } do
      project_to_stakeholder =
        project_to_stakeholder_fixture(
          %{
            "project_id" => proj.id,
            "stakeholder_id" => stakeholder.id,
            "stakeholder_role_id" => role.id
          }
        )

      project_to_stakeholder =
        project_to_stakeholder
        |> Repo.preload(:stakeholder_role)
        |> Repo.preload(:stakeholder)

      assert project_to_stakeholder.stakeholder.first_name == stakeholder.first_name
      assert project_to_stakeholder.stakeholder.last_name == stakeholder.last_name
      assert project_to_stakeholder.stakeholder.title == stakeholder.title

      assert project_to_stakeholder.project_id == proj.id

      assert project_to_stakeholder.stakeholder_role.tag == role.tag

      assert {:ok, %ProjectToStakeholder{}} =
        Research.update_project_to_stakeholder(
          project_to_stakeholder,
           %{
             "stakeholder_role_id" => role_variant.id,
             "stakeholder_id" => stakeholder_variant.id
            }
          )

      project_to_stakeholder =
        Research.get_project_to_stakeholder!(project_to_stakeholder.id)
        |> Repo.preload(:stakeholder_role)
        |> Repo.preload(:stakeholder)

      assert project_to_stakeholder.stakeholder.first_name == stakeholder_variant.first_name
      assert project_to_stakeholder.stakeholder.last_name == stakeholder_variant.last_name
      assert project_to_stakeholder.stakeholder.title == stakeholder_variant.title
      assert project_to_stakeholder.stakeholder_role.tag == role_variant.tag
    end

    test "update_project_to_stakeholder/2 with invalid data returns error changeset", %{project: proj, stakeholder: pers} do
      project_to_stakeholder = project_to_stakeholder_fixture(%{"project_id" => proj.id, "stakeholder_id" => pers.id})
      assert {:error, %Ecto.Changeset{}} = Research.update_project_to_stakeholder(project_to_stakeholder, @invalid_attrs)
      assert project_to_stakeholder == Research.get_project_to_stakeholder!(project_to_stakeholder.id)
    end

    test "delete_project_to_stakeholder/1 deletes the project_to_stakeholder", %{project: proj, stakeholder: pers} do
      Process.sleep(1000) #Needed for a change in date
      time = NaiveDateTime.utc_now()
      projects_before = Research.get_projects_updated_since(time)
      project_to_stakeholder = project_to_stakeholder_fixture(%{"project_id" => proj.id, "stakeholder_id" => pers.id})
      assert {:ok, %ProjectToStakeholder{}} = Research.delete_project_to_stakeholder(project_to_stakeholder)
      assert_raise Ecto.NoResultsError, fn -> Research.get_project_to_stakeholder!(project_to_stakeholder.id) end
      assert projects_before != Research.get_projects_updated_since(time)
    end

    test "change_project_to_stakeholder/1 returns a project_to_stakeholder changeset", %{project: proj, stakeholder: pers} do
      project_to_stakeholder = project_to_stakeholder_fixture(%{"project_id" => proj.id, "stakeholder_id" => pers.id})
      assert %Ecto.Changeset{} = Research.change_project_to_stakeholder(project_to_stakeholder)
    end
  end

  describe "images" do
    setup [:create_project]
    alias Erga.Research.Image

    @valid_attrs %{
      "primary" => true,
      "upload" => %Plug.Upload{path: "test/files/arch.jpg", filename: "arch.jpg"}
    }
    @update_attrs %{"primary" => false}
    @invalid_attrs %{"path" => "nonexistant.jpg"}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_image()

      image
      |> Map.replace!(:labels, [])
    end

    test "create_image/1 with valid data creates a image", %{project: proj} do
      assert {:ok, %Image{} = image} = %{"project_id" => proj.id}
     |> Enum.into(@valid_attrs)
     |> Research.create_image()

      assert image.primary == true
      assert image.path == "projects/#{proj.id}/arch.jpg"
    end

    test "create_image/1 with invalid data returns error changeset", %{project: proj} do

     attr = %{"project_id" => proj.id}
      |> Enum.into(@invalid_attrs)

      assert {:error, %Ecto.Changeset{}} = Research.create_image(attr)
    end

    test "update_image/2 with valid data updates the image", %{project: proj} do
      image = image_fixture(%{"project_id" => proj.id})

     attrs = %{"project_id" => proj.id}
      |> Enum.into(@update_attrs)

      assert {:ok, %Image{} = image} = Research.update_image(image, attrs)
      assert image.primary == false
    end

    test "update_image/2 with invalid data returns error changeset", %{project: proj} do
      image = image_fixture(%{"project_id" => proj.id})
      assert {:error, %Ecto.Changeset{}} = Research.update_image(image, @invalid_attrs)

      image_with_project_not_loaded =
        image
        |> Map.replace!(
          :project,
          %Ecto.Association.NotLoaded{__cardinality__: :one, __field__: :project, __owner__: Erga.Research.Image}
        )

      assert image_with_project_not_loaded == Research.get_image!(image.id)
    end

    test "delete_image/1 deletes the image", %{project: proj} do
      Process.sleep(1000) #Needed for a change in date
      time = NaiveDateTime.utc_now()
      projects_before = Research.get_projects_updated_since(time)
      image = image_fixture(%{"project_id" => proj.id})
      assert {:ok, %Image{}} = Research.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Research.get_image!(image.id) end
      assert projects_before != Research.get_projects_updated_since(time)
    end

    test "change_image/1 returns a image changeset", %{project: proj} do
      image = image_fixture(%{"project_id" => proj.id})
      assert %Ecto.Changeset{} = Research.change_image(image)
    end
  end

  describe "translated_contents" do
    setup [:create_project]
    alias Erga.Research.TranslatedContent

    @valid_attrs %{"text" => "some content", "language_code" => "DE"}
    @update_attrs %{"text" => "some updated content", "language_code" => "IT", "target_id" => 2}
    @invalid_attrs %{"text" => nil, "language_code" => nil}

    def translated_content_fixture(attrs \\ %{}) do
      {:ok, translated_content} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_translated_content()

      translated_content
    end

    test "list_translated_contents/0 returns all translated_contents", %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert Research.list_translated_contents() == [translated_content]
    end

    test "get_translated_content!/1 returns the translated_content with given id",  %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert Research.get_translated_content!(translated_content.id) == translated_content
    end

    test "create_translated_content/1 with valid data creates a translated_content", %{project: proj}  do
      assert {:ok, %TranslatedContent{} = translated_content} =
        %{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"}
        |> Enum.into(@valid_attrs)
        |> Research.create_translated_content
      assert translated_content.text == "some content"
      assert translated_content.language_code == "DE"
    end

    test "create_translated_content/1 with invalid data returns error changeset", %{project: proj}  do
      assert {:error, %Ecto.Changeset{}} =
        %{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"}
        |> Enum.into(@invalid_attrs)
        |> Research.create_translated_content
    end

    test "update_translated_content/2 with valid data updates the translated_content", %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert {:ok, %TranslatedContent{} = translated_content} = Research.update_translated_content(translated_content, @update_attrs)
      assert translated_content.text == "some updated content"
      assert translated_content.language_code == "IT"
    end

    test "update_translated_content/2 with invalid data returns error changeset", %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert {:error, %Ecto.Changeset{}} = Research.update_translated_content(translated_content, @invalid_attrs)
      assert translated_content == Research.get_translated_content!(translated_content.id)
    end

    test "delete_translated_content/1 deletes the translated_content", %{project: proj}  do

      Process.sleep(1000) #Needed for a change in date
      time = NaiveDateTime.utc_now()
      projects_before = Research.get_projects_updated_since(time)
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert {:ok, %TranslatedContent{}} = Research.delete_translated_content(translated_content, %{"target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert_raise Ecto.NoResultsError, fn -> Research.get_translated_content!(translated_content.id) end
      assert projects_before != Research.get_projects_updated_since(time)

    end

    test "change_translated_content/1 returns a translated_content changeset", %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert %Ecto.Changeset{} = Research.change_translated_content(translated_content)
    end
  end

end
