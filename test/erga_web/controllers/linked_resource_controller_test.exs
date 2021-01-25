defmodule ErgaWeb.LinkedResourceControllerTest do
  use ErgaWeb.ConnCase

  alias Erga.Research

  @proj_attrs %{
    project_code: "Test001",
    starts_at: ~D[2019-01-10],
    ends_at: ~D[2023-10-10],
    title_translation_target_id: 1,
  }

  @labels_content [
    %{
      "language_code" => "de",
      "text" => "Berlin, DAI"
    }
  ]

  @descriptions_content [
    %{
      "language_code" => "de",
      "text" => "Der Ort, an dem geschrieben wird.",
    },
    %{
      "language_code" => "en",
      "text" => "The place been written about."
    }
  ]

  @create_attrs %{
    "label" => "Berlin, DAI",
    "description" => "Der Ort, an dem geschrieben wird.",
    "linked_system" => "gazetteer",
    "uri" => "https://gazetteer.dainst.org/place/2282601"
  }

  def fixture(:linked_resource) do
    {:ok, proj} = Research.create_project(@proj_attrs)

    {:ok, lr} =
      %{"project_id" => proj.id}
      |> Enum.into(@create_attrs)
      |> Research.create_linked_resource

    @labels_content
    |> Enum.map(&Map.put(&1, "target_table", "linked_resources"))
    |> Enum.map(&Map.put(&1, "target_table_primary_key", lr.id))
    |> Enum.map(&Map.put(&1, "target_field", "label_translation_target_id"))
    |> Enum.map(&Map.put(&1, "target_id", nil))
    |> Enum.map(&Research.create_translated_content(&1))

    @descriptions_content
    |> Enum.map(&Map.put(&1, "target_table", "linked_resources"))
    |> Enum.map(&Map.put(&1, "target_table_primary_key", lr.id))
    |> Enum.map(&Map.put(&1, "target_field", "description_translation_target_id"))
    |> Enum.map(&Map.put(&1, "target_id", nil))
    |> Enum.map(&Research.create_translated_content(&1))

    lr = Research.get_linked_resource!(lr.id)

    %{project: proj, lr: lr}
  end

  describe "delete linked_resource" do
    setup [:create_linked_resource]

    test "deletes chosen linked_resource", %{conn: conn, project: project, lr: lr} do
      # delete
      conn = delete(conn, Routes.linked_resource_path(conn, :delete, lr))
      redir_path = "/projects/#{project.id}/edit"

      # check if a redirect was requested
      assert redirected_to(conn) =~ redir_path

      # ugly solution for lossing auth assignments in conn recycling
      auth_assigns = conn.assigns
      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, auth_assigns)
        |> get(redir_path)

      # check if the redirected conn gets proper response
      html = assert response(conn, 200)

      # check if deleted resource is no longer on projecte edit page
      refute html =~ "#linked-resource-#{lr.id}"

      lr.labels
      |> Enum.each(fn label ->
        assert_raise(Ecto.NoResultsError, fn -> Research.get_translated_content!(label.id) end)
      end)

      lr.descriptions
      |> Enum.each(fn label ->
        assert_raise(Ecto.NoResultsError, fn -> Research.get_translated_content!(label.id) end)
      end)
    end
  end

  defp create_linked_resource(_) do
    fixture(:linked_resource)
  end
end
