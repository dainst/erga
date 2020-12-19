defmodule ErgaWeb.TranslatedContentControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"text" => "some content", "language_code" => "DE"}
  @update_attrs %{"text" => "some updated content", "language_code" => "IT"}
  @invalid_attrs %{"text" => nil, "language_code" => nil}

  def make_params( attrs, redirect \\ "/" ) do
    {:ok, proj} = create_project()
    attrs = attrs
    |> Enum.into(%{"redirect" => redirect})
    |> Enum.into(%{"target_table_primary_key" => proj.id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
    %{"translated_content" => attrs}
  end

  def fixture(:translated_content, id) do
    {:ok, translated_content} =
      @create_attrs
      |> Enum.into(%{"target_table_primary_key" => id, "target_field" => "title_translation_target_id", "target_table" => "projects"})
      |> Research.create_translated_content()
    translated_content
  end

  describe "new translated_content" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.translated_content_path(conn, :new, %{ redirect: Routes.project_path(conn, :index) }))
      assert html_response(conn, 200) =~ "New Translated content"
    end
  end

  describe "create translated_content" do

    test "redirects to index path if attrs is valid", %{conn: conn} do
      params = make_params(@create_attrs)
      conn = post(conn, Routes.translated_content_path(conn, :create), params)

      assert redirected_to(conn) == Routes.project_path(conn, :index)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      params = make_params( @invalid_attrs )
      conn = post(conn, Routes.translated_content_path(conn, :create, params))
      assert html_response(conn, 200) =~ "New Translated content"
    end
  end

  describe "edit translated_content" do
    setup [:create_translated_content]

    test "renders form for editing chosen translated_content", %{conn: conn, translated_content: translated_content} do
      conn = get(conn, Routes.translated_content_path(conn, :edit, translated_content, %{ redirect: Routes.project_path(conn, :index) }))
      assert html_response(conn, 200) =~ "Edit Translated content"
    end
  end

  describe "update translated_content" do
    setup [:create_translated_content]

    test "redirects when data is valid", %{conn: conn, translated_content: translated_content} do
      params = make_params(@update_attrs)
      conn = put(conn, Routes.translated_content_path(conn, :update, translated_content), params)
      assert redirected_to(conn) == Routes.project_path(conn, :index)

    end

    test "renders errors when data is invalid", %{conn: conn, translated_content: translated_content} do
      params = make_params(@invalid_attrs)
      conn = put(conn, Routes.translated_content_path(conn, :update, translated_content), params )
      assert html_response(conn, 200) =~ "Edit Translated content"
    end
  end

  describe "delete translated_content" do
    setup [:create_translated_content]

    test "deletes chosen translated_content", %{conn: conn, translated_content: translated_content} do
      conn = delete(conn, Routes.translated_content_path(conn, :delete, translated_content.id, %{"target_field" => "title_translation_target_id", "target_table" => "projects", redirect: Routes.project_path(conn, :index) } ))
      assert redirected_to(conn) == Routes.project_path(conn, :index)
    end
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

  defp create_translated_content(_) do
    {:ok, proj}  = create_project()
    translated_content = fixture(:translated_content, proj.id)
    %{translated_content: translated_content}
  end


end
