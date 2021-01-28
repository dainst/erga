defmodule ErgaWeb.StakeholderControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Staff

  @create_attrs %{first_name: "some first_name", last_name: "some last_name", title: "some title", redirect: "some_path"}
  @invalid_attrs %{first_name: nil, last_name: nil, title: nil, redirect: "some_path"}
  @update_attrs %{first_name: "some updated first_name", last_name: "some updated last_name", title: "some updated title", redirect: "some_path"}

  defp fixture(:stakeholder) do
    {:ok, stakeholder} = Staff.create_stakeholder(@create_attrs)
    stakeholder
  end

  describe "index" do
    test "lists all stakeholders", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :index, redirect: "some_path"))
      assert html_response(conn, 200) =~ "Listing Stakeholders"
    end
  end

  describe "new stakeholder" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :new, redirect: "some_path"))
      assert html_response(conn, 200) =~ "New Stakeholder"
    end
  end

  describe "create stakeholder" do
    test "redirects to stakeholder index, preserving redirect parameter when data is valid", %{conn: conn} do

      [location] =
        conn
        |> post(Routes.stakeholder_path(conn, :create), stakeholder: @create_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@create_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some first_name"
      assert html_response(conn, 200) =~  "some last_name"
      assert html_response(conn, 200) =~  "some title"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
    end
  end

  describe "edit stakeholder" do
    setup [:create_stakeholder]

    test "renders form for editing chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = get(conn, Routes.stakeholder_path(conn, :edit, stakeholder, redirect: "redirect_path"))
      assert html_response(conn, 200) =~ "Edit Stakeholder"
    end
  end

  describe "update stakeholder" do
    setup [:create_stakeholder]

    test "redirects to index, preserving redirect parameter when data is valid", %{conn: conn, stakeholder: stakeholder} do

      [location] =
        conn
        |> put(Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @update_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@update_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some updated first_name"
      assert html_response(conn, 200) =~  "some updated last_name"
      assert html_response(conn, 200) =~  "some updated title"
    end

    test "renders errors when data is invalid", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
    end
  end

  describe "delete stakeholder" do
    setup [:create_stakeholder]

    test "deletes chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = delete(conn, Routes.stakeholder_path(conn, :delete, stakeholder, redirect: "/redirect_path"))
      assert redirected_to(conn) == "/redirect_path"

      assert_raise Ecto.NoResultsError, fn -> Staff.get_stakeholder!(stakeholder.id) end
    end
  end

  defp create_stakeholder(_) do
    stakeholder = fixture(:stakeholder)
    %{stakeholder: stakeholder}
  end
end
