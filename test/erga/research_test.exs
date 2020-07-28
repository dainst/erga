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
end
