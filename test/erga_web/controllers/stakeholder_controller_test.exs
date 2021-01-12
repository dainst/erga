defmodule ErgaWeb.StakeholderControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"role" =>"some role"}
  @update_attrs %{"role" => "some updated role"}
  @invalid_attrs %{"project_id" => nil}

  def make_params( attrs ) do
    {:ok, proj} = create_project()
    attrs = attrs
      |> Enum.into(%{"project_id" => proj.id})
    %{"stakeholder" => attrs}
  end

  def fixture(:stakeholder, proj) do
    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => proj.id})
    {:ok, stakeholder} = Research.create_stakeholder(attrs)
    stakeholder
  end

  describe "new stakeholder" do
    test "renders form", %{conn: conn} do
      {:ok, proj} = create_project()
      conn = get(conn, Routes.stakeholder_path(conn, :new, %{"project_id" => proj.id}))
      assert html_response(conn, 200) =~ "New Stakeholder"
    end
  end

  describe "create stakeholder" do
    test "redirects to project when data is valid", %{conn: conn} do
      params = make_params(@create_attrs)
      conn = post(conn, Routes.stakeholder_path(conn, :create), params)

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, params["stakeholder"]["project_id"])

    end
  end

  describe "edit stakeholder" do
    setup [:create_stakeholder]

    test "renders form for editing chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = get(conn, Routes.stakeholder_path(conn, :edit, stakeholder))
      assert html_response(conn, 200) =~ "Edit Stakeholder"
    end
  end

  describe "update stakeholder" do
    setup [:create_stakeholder]

    test "redirects when data is valid", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @update_attrs)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, stakeholder.project_id)

    end

    test "renders errors when data is invalid", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
    end
  end

  describe "delete stakeholder" do
    setup [:create_stakeholder]

    test "deletes chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = delete(conn, Routes.stakeholder_path(conn, :delete, stakeholder))
      assert redirected_to(conn) == Routes.project_path(conn, :edit, stakeholder.project_id)
    end
  end

  defp create_stakeholder(_) do
    {:ok, proj} = create_project()
    stakeholder = fixture(:stakeholder, proj)
    %{stakeholder: stakeholder}
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
