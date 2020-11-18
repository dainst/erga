defmodule ErgaWeb.LinkedResourceLiveTest do
  use ErgaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Erga.Research
  alias ErgaWeb.LinkedResourceLive

  @proj_attrs %{
    project_code: "Test001",
    starts_at: ~D[2019-01-10],
    ends_at: ~D[2023-10-10],
    title_translation_target_id: 1,
  }

  # @title_trans %{
  #   "target_id" => 1,
  #   "language_code" =>  "DE",
  #   "text" => "Projekttitel"
  # }

  @create_attrs %{
    "label" => "la citta eterna",
    "description" => "Der Ort, über den geschrieben wird.",
    #"linked_id" => "2078206",
    "linked_system" => "gazetteer"
  }

  @fixture_attrs %{
    "label" => "Berlin, DAI",
    "description" => "Der Ort, an dem geschrieben wird.",
    #"linked_id" => "2078206",
    "linked_system" => "gazetteer"
  }

  @update_attrs %{
    "label" => "Berlin, Zentrale, DAI",
    "description" => "Der Ort, an dem geforscht wird.",
    #"linked_id" => "2078206",
    "linked_system" => "gazetteer"
  }

  @invalid_attr %{
    "label" => nil,
    "description" => "",
    "linked_system" => "gazetteer"
  }


  defp fixture(:lr) do

    {:ok, proj} = Research.create_project(@proj_attrs)

     {:ok, lr} = %{"project_id" => proj.id}
                 |> Enum.into(@fixture_attrs)
                 |> Research.create_linked_resource
    %{project: proj, lr: lr}
  end

  defp create_lr(_) do
    lr = fixture(:lr)
    lr
  end

  describe "Index" do
    setup [:create_lr]

    test "create new ressource", %{conn: conn, project: project} do
      # load the create page
      {:ok, new_live, html} = live(conn, Routes.live_path(conn, LinkedResourceLive.New, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked resource"

      # try to create a invalid resource, check if "can't be blank" shows up
      assert new_live
             |> form("#linked-resource-form", linked_resource: @invalid_attr)
             |> render_change(%{"_target" => ["test"]}) =~ "can&apos;t be blank"

      # try to create the valid resource
      {:ok, conn} =
        new_live
        |> form("#linked-resource-form", linked_resource: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.project_path(ErgaWeb.Endpoint, :edit, project.id))


      html = assert response(conn, 200)
      # check if the response_body contains the success msg and the label
      assert html =~ "Linked resource created successfully."
      assert html =~ "la citta eterna"
    end

    test "updates resource", %{conn: conn, project: project, lr: lr} do
       # load the create page
       {:ok, edit_live, html} = live(conn, Routes.live_path(conn, LinkedResourceLive.Edit, lr.id))

      # check if the titel is within the html
      assert html =~ "Edit Linked resource"

      # check if the current resource label is within the html
      assert html =~ "Berlin, DAI"

      # updated the current resource with update attrs.
      {:ok, conn} =
        edit_live
        |> form("#linked-resource-form", linked_resource: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.project_path(ErgaWeb.Endpoint, :edit, project.id))

      # check if success message is prompted
      html = assert response(conn, 200)
      assert html =~ "Linked resource updated successfully."

      # check if the new label is within the html
      assert html =~ "Berlin, Zentrale, DAI"
    end


  end
end
