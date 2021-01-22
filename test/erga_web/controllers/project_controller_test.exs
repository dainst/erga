defmodule ErgaWeb.ProjectControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"project_code" => "some project_id"}
  @update_attrs %{"project_code" => "some updated project_id"}
  @invalid_attrs %{"project_code" => nil}

  def fixture(:project) do
    {:ok, project} = Research.create_project(@create_attrs)
    project
  end

  describe "index" do
    test "lists all projects", %{conn: conn} do
      conn = get(conn, Routes.project_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Projects"
    end
  end

  describe "new project" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.project_path(conn, :new))
      assert html_response(conn, 200) =~ "New Project"
    end
  end

  describe "create project" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.project_path(conn, :create), project: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, id)

    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.project_path(conn, :create), project: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Project"
    end
  end

  describe "edit project" do
    setup [:create_project]

    test "renders form for editing chosen project", %{conn: conn, project: project} do
      conn = get(conn, Routes.project_path(conn, :edit, project))
      assert html_response(conn, 200) =~ "Edit Project"
    end
  end

  describe "update project" do
    setup [:create_project]

    test "redirects when data is valid", %{conn: conn, project: project} do
      conn = put(conn, Routes.project_path(conn, :update, project), project: @update_attrs)
      assert redirected_to(conn) == Routes.project_path(conn, :show, project)

    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      conn = put(conn, Routes.project_path(conn, :update, project), project: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Project"
    end
  end

  describe "toggle project status" do
    setup [:create_project]

    test "set chosen project inactive", %{conn: conn, project: project} do
      conn = delete(conn, Routes.project_path(conn, :delete, project))

      assert redirected_to(conn) == Routes.project_path(conn, :index)
      assert get_flash(conn, :info) == "Project deleted successfully."
    end

    test "set chosen project active", %{conn: conn, project: project} do
      # Set inactive first
      {:ok, _ } = Research.update_project(project, %{inactive: true})

      # Toggle back to active
      conn = delete(conn, Routes.project_path(conn, :delete, project))

      assert redirected_to(conn) == Routes.project_path(conn, :index)
      assert get_flash(conn, :info) == "Project restored successfully."
    end
  end

  defp create_project(_) do
    project = fixture(:project)
    %{project: project}
  end
end
