defmodule ErgaWeb.StakeholderControllerTest do
  use ErgaWeb.ConnCase
  alias Erga.Research
  alias Erga.Staff

  @create_attrs %{
    first_name: "some first_name",
    last_name: "some last_name",
    title: "some title",
    orc_id: "https://orcid.org/0000-0000-0000-0000",
    organization_name: "some organization name",
    ror_id: "https://ror.org/023md1f53",
    redirect: "some_path"
  }
  @create_person_attrs %{
    first_name: "some first name",
    last_name: "some last name",
    redirect: "some_path"
  }
  @create_organization_attrs %{
    organization_name: "some organization name",
    redirect: "some_path"
  }

  @missing_data_invalid_attrs %{
    first_name: nil,
    last_name: nil,
    title: nil,
    orc_id: nil,
    organization_name: nil,
    ror_id: nil,
    redirect: "some_path"
  }

  @missing_last_name_invalid_attrs %{
    first_name: "some first_name",
    last_name: nil, redirect:
    "some_path"
  }

  @orc_id_without_name_data_invalid_attrs %{
    orc_id: "https://orcid.org/0000-0000-0000-0000",
    first_name: nil,
    last_name: nil,
    redirect: "some_path"
  }

  @ror_id_without_organization_name_invalid_attrs %{
    ror_id: "https://orcid.org/0000-0000-0000-0000",
    organization_name: nil,
    redirect: "some_path"
  }

  @update_attrs %{
    first_name: "some updated first_name",
    last_name: "some updated last_name",
    title: "some updated title",
    redirect: "some_path"
  }

  defp fixture(:stakeholder) do
    {:ok, stakeholder} = Staff.create_stakeholder(@create_attrs)
    stakeholder
  end

  describe "index" do
    test "lists all stakeholders", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :index, redirect: "some_path"))
      assert html_response(conn, 200) =~ "Listing Stakeholders"
    end
  end

  describe "new stakeholder" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.stakeholder_path(conn, :new, redirect: "some_path"))
      assert html_response(conn, 200) =~ "New Stakeholder"
    end
  end

  describe "create stakeholder" do
    test "redirects to stakeholder index, preserving redirect parameter when data is valid", %{conn: conn} do

      [location] =
        conn
        |> post(Routes.stakeholder_path(conn, :create), stakeholder: @create_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@create_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some first_name"
      assert html_response(conn, 200) =~  "some last_name"
      assert html_response(conn, 200) =~  "https://orcid.org/0000-0000-0000-0000"
      assert html_response(conn, 200) =~  "some organization name"
      assert html_response(conn, 200) =~  "https://ror.org/023md1f53"
    end

    test "creates stakeholder with person data only", %{conn: conn} do
      [location] =
        conn
        |> post(Routes.stakeholder_path(conn, :create), stakeholder: @create_person_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@create_person_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some first name"
      assert html_response(conn, 200) =~  "some last name"
    end

    test "creates stakeholder with organization data only", %{conn: conn} do
      [location] =
        conn
        |> post(Routes.stakeholder_path(conn, :create), stakeholder: @create_organization_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@create_organization_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some organization name"
    end

    test "renders error when missing data", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @missing_data_invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
      assert html_response(conn, 200) =~ "Please input some data."
    end

    test "renders error when first name is set but last name is not", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @missing_last_name_invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
      assert html_response(conn, 200) =~ "Please provide last name when setting first name."
    end

    test "renders error when orc id set but no person name", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @orc_id_without_name_data_invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
      assert html_response(conn, 200) =~ "Please provide last name when setting ORCID."
    end

    test "renders error when ror id set but no organization name", %{conn: conn} do
      conn = post(conn, Routes.stakeholder_path(conn, :create), stakeholder: @ror_id_without_organization_name_invalid_attrs)
      assert html_response(conn, 200) =~ "New Stakeholder"
      assert html_response(conn, 200) =~ "Please provide organization name when setting RORID."
    end
  end

  describe "edit stakeholder" do
    setup [:create_stakeholder]

    test "renders form for editing chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = get(conn, Routes.stakeholder_path(conn, :edit, stakeholder, redirect: "redirect_path"))
      assert html_response(conn, 200) =~ "Edit Stakeholder"
    end
  end

  describe "update stakeholder" do
    setup [:create_stakeholder]

    test "redirects to index, preserving redirect parameter when data is valid", %{conn: conn, stakeholder: stakeholder} do

      [location] =
        conn
        |> put(Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @update_attrs)
        |> Plug.Conn.get_resp_header("location")

      assert location == "/stakeholders?redirect=#{@update_attrs.redirect}"

      conn =
        conn
        |> recycle()
        |> Map.put(:assigns, conn.assigns)
        |> get(location)

      assert html_response(conn, 200) =~  "Listing Stakeholders"
      assert html_response(conn, 200) =~  "some updated first_name"
      assert html_response(conn, 200) =~  "some updated last_name"
    end

    test "renders errors when missing data", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @missing_data_invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
      assert html_response(conn, 200) =~ "Please input some data."
    end

    test "renders errors when first name is set but last name is not", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @missing_last_name_invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
      assert html_response(conn, 200) =~ "Please provide last name when setting first name."
    end

    test "renders error when orc id set but no person name", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @orc_id_without_name_data_invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
      assert html_response(conn, 200) =~ "Please provide last name when setting ORCID."
    end

    test "renders error when ror id set but no organization name", %{conn: conn, stakeholder: stakeholder} do
      conn = put(conn, Routes.stakeholder_path(conn, :update, stakeholder), stakeholder: @ror_id_without_organization_name_invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Stakeholder"
      assert html_response(conn, 200) =~ "Please provide organization name when setting RORID."
    end
  end

  describe "delete stakeholder" do
    setup [:create_stakeholder]

    test "deletes chosen stakeholder", %{conn: conn, stakeholder: stakeholder} do
      conn = delete(conn, Routes.stakeholder_path(conn, :delete, stakeholder, redirect: "/redirect_path"))
      assert redirected_to(conn) == "/stakeholders?redirect=%2Fredirect_path"

      assert_raise Ecto.NoResultsError, fn -> Staff.get_stakeholder!(stakeholder.id) end
    end
  end

  describe "delete stakeholder with linked project" do
    setup [:create_stakeholder_with_linked_project]

    test "deletes chosen stakeholder, returns error", %{conn: conn, stakeholder: stakeholder} do
      conn = delete(conn, Routes.stakeholder_path(conn, :delete, stakeholder, redirect: "/redirect_path"))
      assert redirected_to(conn) == "/stakeholders?redirect=%2Fredirect_path"

      assert Staff.get_stakeholder!(stakeholder.id)!= nil
    end
  end

  defp create_stakeholder_with_linked_project(_) do
    {:ok, proj} = Research.create_project(
      %{
        project_code: "Test001",
        starts_at: ~D[2019-01-10],
        ends_at: ~D[2023-10-10],
        title_translation_target_id: 1,
      }
    )
    {:ok, pers} = Staff.create_stakeholder(
      %{
        first_name: "some first_name",
        last_name: "some last_name",
        title: "some title",
        orc_id: "https://orcid.org/0000-0000-0000-0000",
        organization_name: "some organization name",
        ror_id: "https://ror.org/023md1f53"
      }
    )
    {:ok, %Erga.Research.ProjectToStakeholder{} = project_to_stakeholder} =
      %{"project_id" => proj.id, "stakeholder_id" => pers.id}
      |> Research.create_project_to_stakeholder()
    %{stakeholder: pers}
  end

  defp create_stakeholder(_) do
    stakeholder = fixture(:stakeholder)
    %{stakeholder: stakeholder}
  end
end
