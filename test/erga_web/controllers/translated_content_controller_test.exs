defmodule ErgaWeb.TranslatedContentControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{content: "some content", language_code: "some language_code"}
  @update_attrs %{content: "some updated content", language_code: "some updated language_code"}
  @invalid_attrs %{content: nil, language_code: nil}

  def fixture(:translated_content) do
    {:ok, translated_content} = Research.create_translated_content(@create_attrs)
    translated_content
  end

  describe "index" do
    test "lists all translated_contents", %{conn: conn} do
      conn = get(conn, Routes.translated_content_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Translated contents"
    end
  end

  describe "new translated_content" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.translated_content_path(conn, :new))
      assert html_response(conn, 200) =~ "New Translated content"
    end
  end

  describe "create translated_content" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.translated_content_path(conn, :create), translated_content: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.translated_content_path(conn, :show, id)

      conn = get(conn, Routes.translated_content_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Translated content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.translated_content_path(conn, :create), translated_content: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Translated content"
    end
  end

  describe "edit translated_content" do
    setup [:create_translated_content]

    test "renders form for editing chosen translated_content", %{conn: conn, translated_content: translated_content} do
      conn = get(conn, Routes.translated_content_path(conn, :edit, translated_content))
      assert html_response(conn, 200) =~ "Edit Translated content"
    end
  end

  describe "update translated_content" do
    setup [:create_translated_content]

    test "redirects when data is valid", %{conn: conn, translated_content: translated_content} do
      conn = put(conn, Routes.translated_content_path(conn, :update, translated_content), translated_content: @update_attrs)
      assert redirected_to(conn) == Routes.translated_content_path(conn, :show, translated_content)

      conn = get(conn, Routes.translated_content_path(conn, :show, translated_content))
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, translated_content: translated_content} do
      conn = put(conn, Routes.translated_content_path(conn, :update, translated_content), translated_content: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Translated content"
    end
  end

  describe "delete translated_content" do
    setup [:create_translated_content]

    test "deletes chosen translated_content", %{conn: conn, translated_content: translated_content} do
      conn = delete(conn, Routes.translated_content_path(conn, :delete, translated_content))
      assert redirected_to(conn) == Routes.translated_content_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.translated_content_path(conn, :show, translated_content))
      end
    end
  end

  defp create_translated_content(_) do
    translated_content = fixture(:translated_content)
    %{translated_content: translated_content}
  end
end
