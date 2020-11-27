defmodule ErgaWeb.ImageControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"label" => "bild", "path" => "some path", "primary" => true }
  @update_attrs %{"label" => "pic", "path" => "some updated path", "primary" => false}
  @invalid_attrs %{"label" => nil, "path" => nil, "primary" => nil}

  def make_params( attrs ) do
    {:ok, proj} = create_project()
    attrs =
      attrs
      |> Enum.into(%{"project_id" => proj.id})
    %{"image" => attrs}
  end

  def fixture(:image) do
    {:ok, proj} = create_project()
    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => proj.id})
    {:ok, image} = Research.create_image(attrs)
    image
  end

  describe "new image" do
    test "renders form", %{conn: conn} do
      {:ok, proj} = create_project()
      conn = get(conn, Routes.image_path(conn, :new), %{"project_id" => proj.id})
      assert html_response(conn, 200) =~ "New Image"
    end
  end

  describe "create image" do
    test "redirects to project when data is valid", %{conn: conn} do
      params = make_params(@create_attrs)
      conn = post(conn, Routes.image_path(conn, :create), params)

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, params["image"]["project_id"])

      auth_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, auth_assigns)


      conn = get(conn,Routes.project_path(conn, :edit, params["image"]["project_id"]))
      assert html_response(conn, 200) =~ "Image created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = make_params(@invalid_attrs)
      conn = post(conn, Routes.image_path(conn, :create), params)
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
      params = make_params(@update_attrs)
      conn = put(conn, Routes.image_path(conn, :update, image), params)
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
      params = make_params(@invalid_attrs)
      conn = put(conn, Routes.image_path(conn, :update, image), params)
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

  defp create_image(_) do
    image = fixture(:image)
    %{image: image}
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
