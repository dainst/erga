defmodule Erga.ResearchTest do
  use Erga.DataCase

  alias Erga.Research

  describe "projects" do
    alias Erga.Research.Project

    @valid_attrs %{description: "some description", project_id: "some project_id", title: "some title"}
    @update_attrs %{description: "some updated description", project_id: "some updated project_id", title: "some updated title"}
    @invalid_attrs %{description: nil, project_id: nil, title: nil}

    def project_fixture(attrs \\ %{}) do
      {:ok, project} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_project()

      project
    end

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Research.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Research.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      assert {:ok, %Project{} = project} = Research.create_project(@valid_attrs)
      assert project.description == "some description"
      assert project.project_id == "some project_id"
      assert project.title == "some title"
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      assert {:ok, %Project{} = project} = Research.update_project(project, @update_attrs)
      assert project.description == "some updated description"
      assert project.project_id == "some updated project_id"
      assert project.title == "some updated title"
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_project(project, @invalid_attrs)
      assert project == Research.get_project!(project.id)
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

    @valid_attrs %{context: 42, label: 42, linked_id: "some linked_id", linked_system: "some linked_system", project_id: 42}
    @update_attrs %{context: 43, label: 43, linked_id: "some updated linked_id", linked_system: "some updated linked_system", project_id: 43}
    @invalid_attrs %{context: nil, label: nil, linked_id: nil, linked_system: nil, project_id: nil}

    def linked_resource_fixture(attrs \\ %{}) do
      {:ok, linked_resource} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_linked_resource()

      linked_resource
    end

    test "list_linked_resources/0 returns all linked_resources" do
      linked_resource = linked_resource_fixture()
      assert Research.list_linked_resources() == [linked_resource]
    end

    test "get_linked_resource!/1 returns the linked_resource with given id" do
      linked_resource = linked_resource_fixture()
      assert Research.get_linked_resource!(linked_resource.id) == linked_resource
    end

    test "create_linked_resource/1 with valid data creates a linked_resource" do
      assert {:ok, %LinkedResource{} = linked_resource} = Research.create_linked_resource(@valid_attrs)
      assert linked_resource.context == 42
      assert linked_resource.label == 42
      assert linked_resource.linked_id == "some linked_id"
      assert linked_resource.linked_system == "some linked_system"
      assert linked_resource.project_id == 42
    end

    test "create_linked_resource/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_linked_resource(@invalid_attrs)
    end

    test "update_linked_resource/2 with valid data updates the linked_resource" do
      linked_resource = linked_resource_fixture()
      assert {:ok, %LinkedResource{} = linked_resource} = Research.update_linked_resource(linked_resource, @update_attrs)
      assert linked_resource.context == 43
      assert linked_resource.label == 43
      assert linked_resource.linked_id == "some updated linked_id"
      assert linked_resource.linked_system == "some updated linked_system"
      assert linked_resource.project_id == 43
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
    alias Erga.Research.Stakeholder

    @valid_attrs %{label: "some label", project_id: 42, role: "some role", stakeholder_id: "some stakeholder_id", type: "some type"}
    @update_attrs %{label: "some updated label", project_id: 43, role: "some updated role", stakeholder_id: "some updated stakeholder_id", type: "some updated type"}
    @invalid_attrs %{label: nil, project_id: nil, role: nil, stakeholder_id: nil, type: nil}

    def stakeholder_fixture(attrs \\ %{}) do
      {:ok, stakeholder} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_stakeholder()

      stakeholder
    end

    test "list_stakeholders/0 returns all stakeholders" do
      stakeholder = stakeholder_fixture()
      assert Research.list_stakeholders() == [stakeholder]
    end

    test "get_stakeholder!/1 returns the stakeholder with given id" do
      stakeholder = stakeholder_fixture()
      assert Research.get_stakeholder!(stakeholder.id) == stakeholder
    end

    test "create_stakeholder/1 with valid data creates a stakeholder" do
      assert {:ok, %Stakeholder{} = stakeholder} = Research.create_stakeholder(@valid_attrs)
      assert stakeholder.label == "some label"
      assert stakeholder.project_id == 42
      assert stakeholder.role == "some role"
      assert stakeholder.stakeholder_id == "some stakeholder_id"
      assert stakeholder.type == "some type"
    end

    test "create_stakeholder/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_stakeholder(@invalid_attrs)
    end

    test "update_stakeholder/2 with valid data updates the stakeholder" do
      stakeholder = stakeholder_fixture()
      assert {:ok, %Stakeholder{} = stakeholder} = Research.update_stakeholder(stakeholder, @update_attrs)
      assert stakeholder.label == "some updated label"
      assert stakeholder.project_id == 43
      assert stakeholder.role == "some updated role"
      assert stakeholder.stakeholder_id == "some updated stakeholder_id"
      assert stakeholder.type == "some updated type"
    end

    test "update_stakeholder/2 with invalid data returns error changeset" do
      stakeholder = stakeholder_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_stakeholder(stakeholder, @invalid_attrs)
      assert stakeholder == Research.get_stakeholder!(stakeholder.id)
    end

    test "delete_stakeholder/1 deletes the stakeholder" do
      stakeholder = stakeholder_fixture()
      assert {:ok, %Stakeholder{}} = Research.delete_stakeholder(stakeholder)
      assert_raise Ecto.NoResultsError, fn -> Research.get_stakeholder!(stakeholder.id) end
    end

    test "change_stakeholder/1 returns a stakeholder changeset" do
      stakeholder = stakeholder_fixture()
      assert %Ecto.Changeset{} = Research.change_stakeholder(stakeholder)
    end
  end

  describe "images" do
    alias Erga.Research.Image

    @valid_attrs %{label: 42, path: "some path", project_id: 42}
    @update_attrs %{label: 43, path: "some updated path", project_id: 43}
    @invalid_attrs %{label: nil, path: nil, project_id: nil}

    def image_fixture(attrs \\ %{}) do
      {:ok, image} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_image()

      image
    end

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Research.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Research.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      assert {:ok, %Image{} = image} = Research.create_image(@valid_attrs)
      assert image.label == 42
      assert image.path == "some path"
      assert image.project_id == 42
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      assert {:ok, %Image{} = image} = Research.update_image(image, @update_attrs)
      assert image.label == 43
      assert image.path == "some updated path"
      assert image.project_id == 43
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_image(image, @invalid_attrs)
      assert image == Research.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Research.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Research.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Research.change_image(image)
    end
  end

  describe "translated_contents" do
    alias Erga.Research.TranslatedContent

    @valid_attrs %{content: "some content", language_code: "some language_code"}
    @update_attrs %{content: "some updated content", language_code: "some updated language_code"}
    @invalid_attrs %{content: nil, language_code: nil}

    def translated_content_fixture(attrs \\ %{}) do
      {:ok, translated_content} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Research.create_translated_content()

      translated_content
    end

    test "list_translated_contents/0 returns all translated_contents" do
      translated_content = translated_content_fixture()
      assert Research.list_translated_contents() == [translated_content]
    end

    test "get_translated_content!/1 returns the translated_content with given id" do
      translated_content = translated_content_fixture()
      assert Research.get_translated_content!(translated_content.id) == translated_content
    end

    test "create_translated_content/1 with valid data creates a translated_content" do
      assert {:ok, %TranslatedContent{} = translated_content} = Research.create_translated_content(@valid_attrs)
      assert translated_content.content == "some content"
      assert translated_content.language_code == "some language_code"
    end

    test "create_translated_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Research.create_translated_content(@invalid_attrs)
    end

    test "update_translated_content/2 with valid data updates the translated_content" do
      translated_content = translated_content_fixture()
      assert {:ok, %TranslatedContent{} = translated_content} = Research.update_translated_content(translated_content, @update_attrs)
      assert translated_content.content == "some updated content"
      assert translated_content.language_code == "some updated language_code"
    end

    test "update_translated_content/2 with invalid data returns error changeset" do
      translated_content = translated_content_fixture()
      assert {:error, %Ecto.Changeset{}} = Research.update_translated_content(translated_content, @invalid_attrs)
      assert translated_content == Research.get_translated_content!(translated_content.id)
    end

    test "delete_translated_content/1 deletes the translated_content" do
      translated_content = translated_content_fixture()
      assert {:ok, %TranslatedContent{}} = Research.delete_translated_content(translated_content)
      assert_raise Ecto.NoResultsError, fn -> Research.get_translated_content!(translated_content.id) end
    end

    test "change_translated_content/1 returns a translated_content changeset" do
      translated_content = translated_content_fixture()
      assert %Ecto.Changeset{} = Research.change_translated_content(translated_content)
    end
  end
end
