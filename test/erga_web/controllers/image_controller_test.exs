defmodule ErgaWeb.ImageControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  setup do
    on_exit(fn -> File.rm_rf(Application.get_env(:erga, :uploads_directory)) end)
  end

  @create_attrs %{"label" => "bild", "primary" => true, "upload" => %Plug.Upload{path: "test/files/arch.jpg", filename: "arch.jpg"}}
  @update_attrs %{"label" => "pic", "primary" => false}
  @invalid_attrs %{"label" => nil, "primary" => nil}

  describe "new image" do
    setup [:create_project]
    test "renders form", %{conn: conn, project: project} do
      conn = get(conn, Routes.image_path(conn, :new), %{"project_id" => project.id})
      assert html_response(conn, 200) =~ "New Image"
    end
  end

  describe "create image" do
    setup [:create_project]
    test "redirects to project when data is valid", %{conn: conn, project: project} do
      params =
        @create_attrs
        |> Enum.into(%{"project_id" => project.id})

      conn = post(conn, Routes.image_path(conn, :create), %{"image" => params})

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, params["project_id"])

      auth_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, auth_assigns)


      conn = get(conn,Routes.project_path(conn, :edit, params["project_id"]))
      assert html_response(conn, 200) =~ "Image created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn, project: project} do
      params =
        @invalid_attrs
        |> Enum.into(%{"project_id" => project.id})
      conn = post(conn, Routes.image_path(conn, :create), %{"image" => params})
      assert html_response(conn, 200) =~ "New Image"
    end
  end

  describe "edit image" do
    setup [:create_image]

    test "renders form for editing chosen image", %{conn: conn, image: image} do
      conn = get(conn, Routes.image_path(conn, :edit, image))
      assert html_response(conn, 200) =~ "Edit Image"
    end
  end

  describe "update image" do
    setup [:create_image]

    test "redirects when data is valid", %{conn: conn, image: image} do
      conn = put(conn, Routes.image_path(conn, :update, image), %{"image" => @update_attrs})
      assert redirected_to(conn) == Routes.project_path(conn, :edit, image.project_id)

      auth_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, auth_assigns)

      conn = get(conn, Routes.project_path(conn, :edit, image.project_id))
      assert html_response(conn, 200) =~ "Image updated successfully."
    end

    test "renders errors when data is invalid", %{conn: conn, image: image} do
      conn = put(conn, Routes.image_path(conn, :update, image), %{"image" => @invalid_attrs})
      assert html_response(conn, 200) =~ "Edit Image"
    end
  end

  describe "delete image" do
    setup [:create_image]

    test "deletes chosen image", %{conn: conn, image: image} do
      conn = delete(conn, Routes.image_path(conn, :delete, image))
      assert redirected_to(conn) == Routes.project_path(conn, :edit, image.project_id)
    end
  end

  defp create_image(context) do
    %{project: project} = create_project(context)

    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => project.id})
    {:ok, image} = Research.create_image(attrs)

    %{image: image, project: project}
  end

  defp create_project(_context) do
    {:ok, project} =
      Research.create_project(%{
        project_code: "Test001"
      })

    %{project: project}
  end
end
