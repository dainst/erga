defmodule ErgaWeb.StakeholderControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{label: "some label", project_id: 42, role: "some role", stakeholder_id: "some stakeholder_id", type: "some type"}
  @update_attrs %{label: "some updated label", project_id: 43, role: "some updated role", stakeholder_id: "some updated stakeholder_id", type: "some updated type"}
  @invalid_attrs %{label: nil, project_id: nil, role: nil, stakeholder_id: nil, type: nil}

  def fixture(:stakeholder) do
    {:ok, stakeholder} = Research.create_stakeholder(@create_attrs)
    stakeholder
  end

  describe "index" do
    test "lists all stakeholders", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Stakeholders"
    end
  end

  describe "new stakeholder" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :new))
      assert html_response(conn, 200) =~ "New Stakeholder"
    end
  end

  describe "create stakeholder" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stakeholder_path(conn, :show, id)

      conn = get(conn, Routes.stakeholder_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Stakeholder"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
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
      assert redirected_to(conn) == Routes.stakeholder_path(conn, :show, stakeholder)

      conn = get(conn, Routes.stakeholder_path(conn, :show, stakeholder))
      assert html_response(conn, 200) =~ "some updated label"
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
      assert redirected_to(conn) == Routes.stakeholder_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.stakeholder_path(conn, :show, stakeholder))
      end
    end
  end

  defp create_stakeholder(_) do
    stakeholder = fixture(:stakeholder)
    %{stakeholder: stakeholder}
  end
end
