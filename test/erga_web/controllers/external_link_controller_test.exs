defmodule ErgaWeb.ExternalLinkControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @create_attrs %{"url" =>"https://wwww.dainst.org"}
  @update_attrs %{"url" => "https://idai.world"}
  @invalid_attrs %{"url" => nil}

  @labels_content [
    %{
      "language_code" => "de",
      "text" => "Deutsches Archäolisches Institut"
    },
    %{
      "language_code" => "en",
      "text" => "German Archaeological Institute"
    }
  ]

  describe "new external link" do
    setup [:create_project]
    test "renders form", %{conn: conn, project: project} do
      conn = get(conn, Routes.external_link_path(conn, :new, %{"project_id" => project.id}))
      assert html_response(conn, 200) =~ "New External link"
    end
  end

  describe "create external_link" do
    setup [:create_project]
    test "redirects to project when data is valid", %{conn: conn, project: project} do
      params =
        @create_attrs
        |> Enum.into(%{"project_id" => project.id})

      conn = post(conn, Routes.external_link_path(conn, :create), %{"external_link" => params})

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.external_link_path(conn, :edit, id)
    end
  end

  describe "edit external link" do
    setup [:create_external_link]

    test "renders form for editing chosen external link", %{conn: conn, external_link: external_link} do
      conn = get(conn, Routes.external_link_path(conn, :edit, external_link))
      assert html_response(conn, 200) =~ "Edit External link"
    end
  end

  describe "update external link" do
    setup [:create_external_link]

    test "redirects when data is valid", %{conn: conn, external_link: external_link} do
      conn = put(conn, Routes.external_link_path(conn, :update, external_link), external_link: @update_attrs)
      assert redirected_to(conn) == Routes.project_path(conn, :edit, external_link.project_id)
    end

    test "renders errors when data is invalid", %{conn: conn, external_link: external_link} do
      conn = put(conn, Routes.external_link_path(conn, :update, external_link), external_link: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit External link"
    end
  end

  describe "delete external_link" do
    setup [:create_external_link]

    test "deletes chosen external link", %{conn: conn, external_link: external_link} do
      conn = delete(conn, Routes.external_link_path(conn, :delete, external_link))
      assert redirected_to(conn) == Routes.project_path(conn, :edit, external_link.project_id)

      external_link.labels
      |> Enum.each(fn label ->
        assert_raise(Ecto.NoResultsError, fn -> Research.get_translated_content!(label.id) end)
      end)
    end
  end

  defp create_external_link(context) do
    %{project: project} = create_project(context)
    attrs =
      @create_attrs
      |> Enum.into(%{"project_id" => project.id})

    {:ok, external_link} = Research.create_external_link(attrs)

    create_labels(external_link)

    external_link = Research.get_external_link!(external_link.id)

    %{external_link: external_link, project: project}
  end

  defp create_project(_context) do
    {:ok, project} =
      Research.create_project(%{
        project_code: "Test001"
      })

    %{project: project}
  end

  defp create_labels(external_link) do
    @labels_content
    |> Enum.map(&Map.put(&1, "target_table", "external_links"))
    |> Enum.map(&Map.put(&1, "target_table_primary_key", external_link.id))
    |> Enum.map(&Map.put(&1, "target_field", "label_translation_target_id"))
    |> Enum.map(&Map.put(&1, "target_id", nil))
    |> Enum.map(&Research.create_translated_content(&1))
  end
end
