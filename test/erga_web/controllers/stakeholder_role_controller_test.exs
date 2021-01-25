defmodule ErgaWeb.StakeholderRoleControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Staff

  @redirect "some_path"

  @create_attrs %{key: "some key", redirect: @redirect}
  @update_attrs %{key: "some updated key", redirect: @redirect}
  @invalid_attrs %{key: nil, redirect: @redirect}


  def fixture(:stakeholder_role) do
    {:ok, stakeholder_role} = Staff.create_stakeholder_role(@create_attrs)
    stakeholder_role
  end

  describe "index" do
    test "lists all stakeholder_roles", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_role_path(conn, :index, redirect: @redirect))
      assert html_response(conn, 200) =~ "Listing Stakeholder roles"
    end
  end

  describe "new stakeholder_role" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_role_path(conn, :new, redirect: @redirect))
      assert html_response(conn, 200) =~ "New Stakeholder role"
    end
  end

  describe "create stakeholder_role" do
    test "redirects to show when data is valid", %{conn: conn} do

      [location] =
        conn
        |> post(Routes.stakeholder_role_path(conn, :create, stakeholder_role: @create_attrs))
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholder_roles?redirect=#{@update_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholder roles"
      assert html_response(conn, 200) =~  "some key"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_role_path(conn, :create), stakeholder_role: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder role"
    end
  end

  describe "edit stakeholder_role" do
    setup [:create_stakeholder_role]

    test "renders form for editing chosen stakeholder_role", %{conn: conn, stakeholder_role: stakeholder_role} do
      conn = get(conn, Routes.stakeholder_role_path(conn, :edit, stakeholder_role, redirect: @redirect))
      assert html_response(conn, 200) =~ "Edit Stakeholder role"
    end
  end

  describe "update stakeholder_role" do
    setup [:create_stakeholder_role]

    test "redirects to index, preserving redirect parameter when data is valid", %{conn: conn, stakeholder_role: stakeholder_role} do

      conn =
        conn
        |> put(Routes.stakeholder_role_path(conn, :update, stakeholder_role), stakeholder_role: @update_attrs)

      [location] =
        conn
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholder_roles?redirect=#{@update_attrs.redirect}"
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholder roles"
      assert html_response(conn, 200) =~  "some updated key"
    end

    test "renders errors when data is invalid", %{conn: conn, stakeholder_role: stakeholder_role} do
      conn = put(conn, Routes.stakeholder_role_path(conn, :update, stakeholder_role), stakeholder_role: @invalid_attrs, redirect: @redirect)
      assert html_response(conn, 200) =~ "Edit Stakeholder role"
    end
  end

  describe "delete stakeholder_role" do
    setup [:create_stakeholder_role]

    test "deletes chosen stakeholder_role", %{conn: conn, stakeholder_role: stakeholder_role} do
      conn = delete(conn, Routes.stakeholder_role_path(conn, :delete, stakeholder_role))
      assert redirected_to(conn) == Routes.stakeholder_role_path(conn, :index)

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)

      assert_error_sent 404, fn ->
        get(conn, Routes.stakeholder_role_path(conn, :edit, stakeholder_role, redirect: @create_attrs.redirect))
      end
    end
  end

  defp create_stakeholder_role(_) do
    stakeholder_role = fixture(:stakeholder_role)
    %{stakeholder_role: stakeholder_role}
  end
end
