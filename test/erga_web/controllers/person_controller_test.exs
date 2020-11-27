defmodule ErgaWeb.PersonControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Staff

  @create_attrs %{firstname: "some firstname", lastname: "some lastname", title: "some title", redirect: "/redirect_path"}
  @invalid_attrs %{firstname: nil, lastname: nil, title: nil, redirect: "/redirect_path"}
  @update_attrs %{firstname: "some updated firstname", lastname: "some updated lastname", title: "some updated title", redirect: "/redirect_path"}

  defp fixture(:person) do
    {:ok, person} = Staff.create_person(@create_attrs)
    person
  end

  describe "index" do
    test "lists all persons", %{conn: conn} do
      conn = get(conn, Routes.person_path(conn, :index, redirect: "/redirect_path"))
      assert html_response(conn, 200) =~ "Listing Persons"
    end
  end

  describe "new person" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.person_path(conn, :new, redirect: "/redirect_path"))
      assert html_response(conn, 200) =~ "New Person"
    end
  end

  describe "create person" do
    test "redirects to show when data is valid", %{conn: conn} do

      [location] =
        conn
        |> post(Routes.person_path(conn, :create), person: @create_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == @create_attrs.redirect
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.person_path(conn, :create), person: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Person"
    end
  end

  describe "edit person" do
    setup [:create_person]

    test "renders form for editing chosen person", %{conn: conn, person: person} do
      conn = get(conn, Routes.person_path(conn, :edit, person, redirect: "/redirect_path"))
      assert html_response(conn, 200) =~ "Edit Person"
    end
  end

  describe "update person" do
    setup [:create_person]

    test "redirects when data is valid", %{conn: conn, person: person} do

      [location] =
        conn
        |> put(Routes.person_path(conn, :update, person), person: @update_attrs)
        |> Plug.Conn.get_resp_header("location")

        assert location == @update_attrs.redirect
    end

    test "renders errors when data is invalid", %{conn: conn, person: person} do
      conn = put(conn, Routes.person_path(conn, :update, person), person: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Person"
    end
  end

  describe "delete person" do
    setup [:create_person]

    test "deletes chosen person", %{conn: conn, person: person} do
      conn = delete(conn, Routes.person_path(conn, :delete, person, redirect: "/redirect_path"))
      assert redirected_to(conn) == "/redirect_path"

      assert_raise Ecto.NoResultsError, fn -> Staff.get_person!(person.id) end
    end
  end

  defp create_person(_) do
    person = fixture(:person)
    %{person: person}
  end
end
