defmodule ErgaWeb.LinkedResourceLiveTest do
  use ErgaWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Erga.Research

  @proj_attrs %{
    project_code: "Test001",
    starts_at: ~D[2019-01-10],
    ends_at: ~D[2023-10-10]
  }

  @gazetteer_uri  "https://gazetteer.dainst.org/2078206"


  @fixture_attrs %{
    "label" => "Berlin, DAI",
    "description" => "Der Ort, an dem geschrieben wird.",
    "uri" => "https://gazetteer.dainst.org/2078206",
    "linked_system" => "gazetteer"
  }

  @create_attrs %{
    "label" => "la citta eterna",
    "description" => "Der Ort, über den geschrieben wird."
  }

  @update_attrs %{
    "label" => "Berlin, Zentrale, DAI"
  }

  @invalid_attr %{
    "label" => nil
  }

  defp create_linked_resource(context) do
    %{project: project} = create_project(context)
    {:ok, linked_resource} =
      %{"project_id" => project.id}
      |> Enum.into(@fixture_attrs)
      |> Research.create_linked_resource
    %{project: project, linked_resource: linked_resource}
  end

  defp create_project(_context) do
    {:ok, project} = Research.create_project(@proj_attrs)
    %{project: project}
  end

  describe "new linked resource" do
    setup [:create_project]

    test "redirects to project when data is valid", %{conn: conn, project: project} do
      # load the create page
      {:ok, new_live, html} = live(conn, Routes.linked_resource_path(conn, :new, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked Resource"

      # try to create a invalid resource, check if "can't be blank" shows up
      form_with_error =
        new_live
        |> form("#linked-resource-form", linked_resource: @invalid_attr)
        |> render_change(%{"_target" => ["test"]})

      assert form_with_error =~ "can&apos;t be blank"

      # try to create the valid resource
      {:ok, conn} =
        new_live
        |> form("#linked-resource-form", linked_resource: @create_attrs)
        # Hidden form fields have to be passed with render_submit
        |> render_submit(%{linked_resource: %{"project_id" => project.id, "uri" => @gazetteer_uri}})
        |> follow_redirect(conn, Routes.project_path(ErgaWeb.Endpoint, :edit, project.id))

      html = assert response(conn, 200)
      # check if the response_body contains the success msg and the label
      assert html =~ "Linked resource created successfully."
      assert html =~ "la citta eterna"
    end
  end

  describe "edit linked resource" do
    setup [:create_linked_resource]
    test "redirects when data is valid", %{conn: conn, project: project, linked_resource: linked_resource} do

      # load the create page
      {:ok, edit_live, html} = live(conn, Routes.linked_resource_path(conn, :edit, linked_resource.id))

      # check if the titel is within the html
      assert html =~ "Edit Linked Resource"

      # check if the current resource label is within the html
      assert html =~ "Berlin, DAI"

      # updated the current resource with update attrs.
      {:ok, conn} =
        edit_live
        |> form("#linked-resource-form", linked_resource: @update_attrs)
        |> render_submit(%{linked_resource: %{"uri" => "https://gazetteer.dainst.org/place/2323293"}})
        |> follow_redirect(conn, Routes.project_path(ErgaWeb.Endpoint, :edit, project.id))

      # check if success message is prompted
      html = assert response(conn, 200)
      assert html =~ "Linked resource updated successfully."

      # check if the new label is within the html
      assert html =~ "Berlin, Zentrale, DAI"
    end
  end

  describe "searching external service" do
    setup [:create_project]

    test "gazetteer", %{conn: conn, project: project} do
      # load the create page
      {:ok, new_live, html} = live(conn, Routes.linked_resource_path(conn, :new, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked Resource"

      view =
        new_live
        |> render_change("form_change", %{"_target" => ["search_string"], "linked_resource" => %{"search_string" => "Berlin"}})

      assert view =~ "https://gazetteer.dainst.org/place/2282601"
    end

    test "chronontology", %{conn: conn, project: project} do
      # load the create page
      {:ok, view, html} = live(conn, Routes.linked_resource_path(conn, :new, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked Resource"

      # switch to chronontology searching
      render_change(view, "form_change", %{"_target" => ["linked_system"], "linked_resource" => %{"linked_system" => "chronontology"}})
      # run search
      html =
        view
        |> render_change("form_change", %{"_target" => ["search_string"], "linked_resource" => %{"search_string" => "Bronzezeit"}})

      assert html =~ "https://chronontology.dainst.org/period/rYh7ggsMyaSj"
    end

    test "thesauri", %{conn: conn, project: project} do
      # load the create page
      {:ok, view, html} = live(conn, Routes.linked_resource_path(conn, :new, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked Resource"

      # switch to thesauri searching
      render_change(view, "form_change", %{"_target" => ["linked_system"], "linked_resource" => %{"linked_system" => "thesaurus"}})
      # run search
      html =
        view
        |> render_change("form_change", %{"_target" => ["search_string"], "linked_resource" => %{"search_string" => "Kirsch"}})

      assert html =~ "http://thesauri.dainst.org/_1cd2807d"
    end

    test "arachne", %{conn: conn, project: project} do
      # load the create page
      {:ok, view, html} = live(conn, Routes.linked_resource_path(conn, :new, project.id))

      # check if the returning html contains the title
      assert html =~ "New Linked Resource"

      # switch to arachne searching
      render_change(view, "form_change", %{"_target" => ["linked_system"], "linked_resource" => %{"linked_system" => "arachne"}})
      # run search
      html =
        view
        |> render_change("form_change", %{"_target" => ["search_string"], "linked_resource" => %{"search_string" => "laokoon"}})

      assert html =~ "http://arachne.dainst.org/entity/1140385"
    end
  end
end
