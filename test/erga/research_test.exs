defmodule Erga.ResearchTest do
  use Erga.DataCase

  alias Erga.Research
  alias Erga.Staff

  defp create_project(_) do
    {:ok, proj} = Research.create_project(%{
      project_code: "Test001",
      starts_at: ~D[2019-01-10],
      ends_at: ~D[2023-10-10],
      title_translation_target_id: 1,
    })
    %{project: proj}
  end

  defp create_person(_) do
    {:ok, pers} = Staff.create_person( %{
      firstname: "some firstname",
      lastname: "some lastname",
      title: "some title"
    })
    %{person: pers}
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
    # test "list_projects/0 returns all projects" do
    #   project = project_fixture()
    #   assert Research.list_projects() == [project]
    # end

    # test "get_project!/1 returns the project with given id" do
    #   project = project_fixture()
    #   assert Research.get_project!(project.id) == project
    # end

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

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Research.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Research.get_project!(project.id) end
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
      "label" => "Berlin, DAI",
      "description" => "Der Ort, an dem geschrieben wird.",
      "linked_system" => "gazetteer",
      "linked_id" => "12345" }
    @update_attrs %{
      "label" => "Berlin, Zentrale, DAI",
      "description" => "Der Ort, an dem geforscht wird.",
      "linked_system" => "gazetteer",
      "linked_id" => "54321"
    }
    @invalid_attrs %{
      "label" => nil,
      "description" => "",
      "linked_system" => "gazetteer"}

    def linked_resource_fixture(_attrs \\ %{}) do
      {:ok, proj} = Research.create_project(@proj_attrs)
      {:ok, linked_resource} =
        %{"project_id" => proj.id}
        |> Enum.into(@valid_attrs)
        |> Research.create_linked_resource()

      Research.get_linked_resource!(linked_resource.id)
    end

    test "list_linked_resources/0 returns all linked_resources" do
      linked_resource = linked_resource_fixture()
      assert linked_resource in Research.list_linked_resources()
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
      assert linked_resource.description == "Der Ort, an dem geschrieben wird."
      assert linked_resource.label == "Berlin, DAI"
      assert linked_resource.linked_system == "gazetteer"
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
      assert linked_resource.description == "Der Ort, an dem geforscht wird."
      assert linked_resource.label == "Berlin, Zentrale, DAI"
      assert linked_resource.linked_system == "gazetteer"
    end

    test "update_linked_resource/2 with invalid data returns error changeset" do
      linked_resource = linked_resource_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_linked_resource(linked_resource, @invalid_attrs)
      assert linked_resource == Research.get_linked_resource!(linked_resource.id)
    end

    test "delete_linked_resource/1 deletes the linked_resource" do
      linked_resource = linked_resource_fixture()
      assert {:ok, %LinkedResource{}} = Research.delete_linked_resource(linked_resource)
      assert_raise Ecto.NoResultsError, fn -> Research.get_linked_resource!(linked_resource.id) end
    end

    test "change_linked_resource/1 returns a linked_resource changeset" do
      linked_resource = linked_resource_fixture()
      assert %Ecto.Changeset{} = Research.change_linked_resource(linked_resource)
    end
  end

  describe "stakeholders" do
    setup [:create_project, :create_person]

    alias Erga.Research.Stakeholder

    @valid_attrs %{ "role" => "some role", "external_id" => "some stakeholder_id"}
    @update_attrs %{  "role" => "some updated role", "external_id" => "some updated stakeholder_id"}
    @invalid_attrs %{"person_id" => nil, "project_id" => nil, "role" => nil, "external_id" => nil}

    def stakeholder_fixture(attrs \\ %{}) do
      {:ok, stakeholder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_stakeholder()

      Research.get_stakeholder!(stakeholder.id)
    end

    test "list_stakeholders/0 returns all stakeholders", %{project: proj} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id})
      assert Research.list_stakeholders() == [stakeholder]
    end

    test "get_stakeholder!/1 returns the stakeholder with given id", %{project: proj, person: pers} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id, "person_id" => pers.id})
      assert Research.get_stakeholder!(stakeholder.id) == stakeholder
    end

    test "create_stakeholder/1 with valid data creates a stakeholder", %{project: proj, person: pers} do
      assert {:ok, %Stakeholder{} = stakeholder} =
        %{"project_id" => proj.id, "person_id" => pers.id}
        |> Enum.into(@valid_attrs)
        |> Research.create_stakeholder()
      assert stakeholder.person_id == pers.id
      assert stakeholder.project_id == proj.id
      assert stakeholder.role == "some role"
      assert stakeholder.external_id == "some stakeholder_id"
    end

    test "create_stakeholder/1 with invalid data returns error changeset", %{project: proj, person: pers}  do
      assert {:error, %Ecto.Changeset{}} =
        %{"project_id" => proj.id, "person_id" => pers.id}
        |> Enum.into(@invalid_attrs)
        |> Research.create_stakeholder()
    end

    test "update_stakeholder/2 with valid data updates the stakeholder", %{project: proj, person: pers} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id, "person_id" => pers.id})
      assert {:ok, %Stakeholder{} = stakeholder} = Research.update_stakeholder(stakeholder, @update_attrs)
      assert stakeholder.person_id == pers.id
      assert stakeholder.project_id == proj.id
      assert stakeholder.role == "some updated role"
      assert stakeholder.external_id == "some updated stakeholder_id"
    end

    test "update_stakeholder/2 with invalid data returns error changeset", %{project: proj, person: pers} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id, "person_id" => pers.id})
      assert {:error, %Ecto.Changeset{}} = Research.update_stakeholder(stakeholder, @invalid_attrs)
      assert stakeholder == Research.get_stakeholder!(stakeholder.id)
    end

    test "delete_stakeholder/1 deletes the stakeholder", %{project: proj, person: pers} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id, "person_id" => pers.id})
      assert {:ok, %Stakeholder{}} = Research.delete_stakeholder(stakeholder)
      assert_raise Ecto.NoResultsError, fn -> Research.get_stakeholder!(stakeholder.id) end
    end

    test "change_stakeholder/1 returns a stakeholder changeset", %{project: proj, person: pers} do
      stakeholder = stakeholder_fixture(%{"project_id" => proj.id, "person_id" => pers.id})
      assert %Ecto.Changeset{} = Research.change_stakeholder(stakeholder)
    end
  end

  describe "images" do
    setup [:create_project]
    alias Erga.Research.Image

    @valid_attrs %{"label" => "pic", "path" => "some path", "primary" => true}
    @update_attrs %{"label" => "puc", "path" => "some updated path", "primary" => false}
    @invalid_attrs %{"label" => nil, "path" => nil, }

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_image()

      image
    end

    # test "list_images/0 returns all images", %{project: proj}  do
    #   image = image_fixture(%{"project_id" => proj.id})
    #   assert Research.list_images() == [image]
    # end

    # test "get_image!/1 returns the image with given id", %{project: proj} do
    #   image = image_fixture(%{"project_id" => proj.id})
    #   assert Research.get_image!(image.id) == image
    # end

    test "create_image/1 with valid data creates a image", %{project: proj} do
      assert {:ok, %Image{} = image} = %{"project_id" => proj.id}
     |> Enum.into(@valid_attrs)
     |> Research.create_image()

      assert image.label == "pic"
      assert image.path == "some path"
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
      assert image.label == "puc"
      assert image.path == "some updated path"
    end

    test "update_image/2 with invalid data returns error changeset", %{project: proj} do
      image = image_fixture(%{"project_id" => proj.id})
      assert {:error, %Ecto.Changeset{}} = Research.update_image(image, @invalid_attrs)
      #assert image == Research.get_image!(image.id)
    end

    test "delete_image/1 deletes the image", %{project: proj} do
      image = image_fixture(%{"project_id" => proj.id})
      assert {:ok, %Image{}} = Research.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Research.get_image!(image.id) end
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

    # test "list_translated_contents/0 returns all translated_contents", %{project: proj}  do
    #   translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
    #   assert Research.list_translated_contents() == [translated_content]
    # end

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
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert {:ok, %TranslatedContent{}} = Research.delete_translated_content(translated_content, %{"target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert_raise Ecto.NoResultsError, fn -> Research.get_translated_content!(translated_content.id) end
    end

    test "change_translated_content/1 returns a translated_content changeset", %{project: proj}  do
      translated_content = translated_content_fixture(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      assert %Ecto.Changeset{} = Research.change_translated_content(translated_content)
    end
  end

end
