defmodule ErgaWeb.ImageControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @uploads_directory Application.get_env(:erga, :uploads_directory)

  setup do
    on_exit(fn -> File.rm_rf(@uploads_directory) end)
  end

  @create_attrs %{"primary" => true, "upload" => %Plug.Upload{path: "test/files/arch.jpg", filename: "arch.jpg"}}
  @update_attrs %{"primary" => false}
  @invalid_attrs %{"path" => "nonexistant.jpg"}


  @labels_content [
    %{
      "language_code" => "de",
      "text" => "Ein Testbild"
    },
    %{
      "language_code" => "en",
      "text" => "Sample image"
    }
  ]

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

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.image_path(conn, :edit, id)

      auth_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, auth_assigns)


      conn = get(conn,Routes.project_path(conn, :edit, params["project_id"]))
      assert html_response(conn, 200) =~ "Image created successfully"
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
      assert File.exists?("#{@uploads_directory}/#{image.path}")

      conn = delete(conn, Routes.image_path(conn, :delete, image))

      assert !File.exists?("#{@uploads_directory}/#{image.path}")
      assert redirected_to(conn) == Routes.project_path(conn, :edit, image.project_id)

      image.labels
      |> Enum.each(fn label ->
        assert_raise(Ecto.NoResultsError, fn -> Research.get_translated_content!(label.id) end)
      end)
    end
  end

  defp create_image(context) do
    %{project: project} = create_project(context)

    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => project.id})
    {:ok, image} = Research.create_image(attrs)

    create_labels(image)

    image = Research.get_image!(image.id)

    %{image: image, project: project}
  end

  defp create_project(_context) do
    {:ok, project} =
      Research.create_project(%{
        project_code: "Test001"
      })

    %{project: project}
  end

  defp create_labels(image) do
    @labels_content
    |> Enum.map(&Map.put(&1, "target_table", "images"))
    |> Enum.map(&Map.put(&1, "target_table_primary_key", image.id))
    |> Enum.map(&Map.put(&1, "target_field", "label_translation_target_id"))
    |> Enum.map(&Map.put(&1, "target_id", nil))
    |> Enum.map(&Research.create_translated_content(&1))
  end
end
