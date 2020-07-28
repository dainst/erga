defmodule ErgaWeb.LinkedResourceControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{context: 42, label: 42, linked_id: "some linked_id", linked_system: "some linked_system", project_id: 42}
  @update_attrs %{context: 43, label: 43, linked_id: "some updated linked_id", linked_system: "some updated linked_system", project_id: 43}
  @invalid_attrs %{context: nil, label: nil, linked_id: nil, linked_system: nil, project_id: nil}

  def fixture(:linked_resource) do
    {:ok, linked_resource} = Research.create_linked_resource(@create_attrs)
    linked_resource
  end

  describe "index" do
    test "lists all linked_resources", %{conn: conn} do
      conn = get(conn, Routes.linked_resource_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Linked resources"
    end
  end

  describe "new linked_resource" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.linked_resource_path(conn, :new))
      assert html_response(conn, 200) =~ "New Linked resource"
    end
  end

  describe "create linked_resource" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.linked_resource_path(conn, :create), linked_resource: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.linked_resource_path(conn, :show, id)

      conn = get(conn, Routes.linked_resource_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Linked resource"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.linked_resource_path(conn, :create), linked_resource: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Linked resource"
    end
  end

  describe "edit linked_resource" do
    setup [:create_linked_resource]

    test "renders form for editing chosen linked_resource", %{conn: conn, linked_resource: linked_resource} do
      conn = get(conn, Routes.linked_resource_path(conn, :edit, linked_resource))
      assert html_response(conn, 200) =~ "Edit Linked resource"
    end
  end

  describe "update linked_resource" do
    setup [:create_linked_resource]

    test "redirects when data is valid", %{conn: conn, linked_resource: linked_resource} do
      conn = put(conn, Routes.linked_resource_path(conn, :update, linked_resource), linked_resource: @update_attrs)
      assert redirected_to(conn) == Routes.linked_resource_path(conn, :show, linked_resource)

      conn = get(conn, Routes.linked_resource_path(conn, :show, linked_resource))
      assert html_response(conn, 200) =~ "some updated linked_id"
    end

    test "renders errors when data is invalid", %{conn: conn, linked_resource: linked_resource} do
      conn = put(conn, Routes.linked_resource_path(conn, :update, linked_resource), linked_resource: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Linked resource"
    end
  end

  describe "delete linked_resource" do
    setup [:create_linked_resource]

    test "deletes chosen linked_resource", %{conn: conn, linked_resource: linked_resource} do
      conn = delete(conn, Routes.linked_resource_path(conn, :delete, linked_resource))
      assert redirected_to(conn) == Routes.linked_resource_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.linked_resource_path(conn, :show, linked_resource))
      end
    end
  end

  defp create_linked_resource(_) do
    linked_resource = fixture(:linked_resource)
    %{linked_resource: linked_resource}
  end
end
