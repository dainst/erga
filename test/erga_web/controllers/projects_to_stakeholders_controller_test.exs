defmodule ErgaWeb.ProjectTOStakeholderControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"role" =>"some role"}
  @update_attrs %{"role" => "some updated role"}
  @invalid_attrs %{"project_id" => nil}

  def make_params( attrs ) do
    {:ok, proj} = create_project()
    attrs = attrs
      |> Enum.into(%{"project_id" => proj.id})
    %{"project_to_stakeholder" => attrs}
  end

  def fixture(:project_to_stakeholder, proj) do
    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => proj.id})
    {:ok, project_to_stakeholder} = Research.create_project_to_stakeholder(attrs)
    project_to_stakeholder
  end

  describe "new project_to_stakeholder" do
    test "renders form", %{conn: conn} do
      {:ok, proj} = create_project()
      conn = get(conn, Routes.project_to_stakeholder_path(conn, :new, %{"project_id" => proj.id}))
      assert html_response(conn, 200) =~ "Add stakeholder to project"
    end
  end

  describe "create project_to_stakeholder" do
    test "redirects to project when data is valid", %{conn: conn} do
      params = make_params(@create_attrs)
      conn = post(conn, Routes.project_to_stakeholder_path(conn, :create), params)

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, params["project_to_stakeholder"]["project_id"])

    end
  end

  describe "edit project_to_stakeholder" do
    setup [:create_project_to_stakeholder]

    test "renders form for editing chosen project_to_stakeholder", %{conn: conn, project_to_stakeholder: project_to_stakeholder} do
      conn = get(conn, Routes.project_to_stakeholder_path(conn, :edit, project_to_stakeholder))
      assert html_response(conn, 200) =~ "Edit project's stakeholder"
    end
  end

  describe "update project_to_stakeholder" do
    setup [:create_project_to_stakeholder]

    test "redirects when data is valid", %{conn: conn, project_to_stakeholder: project_to_stakeholder} do
      conn = put(conn, Routes.project_to_stakeholder_path(conn, :update, project_to_stakeholder), project_to_stakeholder: @update_attrs)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, project_to_stakeholder.project_id)

    end

    test "renders errors when data is invalid", %{conn: conn, project_to_stakeholder: project_to_stakeholder} do
      conn = put(conn, Routes.project_to_stakeholder_path(conn, :update, project_to_stakeholder), project_to_stakeholder: @invalid_attrs)

      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below."
      assert html_response(conn, 200) =~ "Edit project's stakeholder"
    end
  end

  describe "delete project_to_stakeholder" do
    setup [:create_project_to_stakeholder]

    test "deletes chosen project_to_stakeholder", %{conn: conn, project_to_stakeholder: project_to_stakeholder} do
      conn = delete(conn, Routes.project_to_stakeholder_path(conn, :delete, project_to_stakeholder))
      assert redirected_to(conn) == Routes.project_path(conn, :edit, project_to_stakeholder.project_id)
    end
  end

  defp create_project_to_stakeholder(_) do
    {:ok, proj} = create_project()
    project_to_stakeholder = fixture(:project_to_stakeholder, proj)
    %{project_to_stakeholder: project_to_stakeholder}
  end

  defp create_project() do
    proj =
      try do
        Research.get_project_by_code!("Test001")
      rescue
        Ecto.NoResultsError ->
          {:ok, proj} = Research.create_project(%{
            project_code: "Test001",
            starts_at: ~D[2019-01-10],
            ends_at: ~D[2023-10-10],
            title_translation_target_id: 1,
          })
          proj
      end
    {:ok, proj}
  end
end
