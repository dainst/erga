defmodule ErgaWeb.ProjectToStakeholderController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.ProjectToStakeholder
  alias Erga.Staff

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_project_to_stakeholder(%ProjectToStakeholder{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    stakeholders = Staff.list_stakeholders()
    stakeholder_roles = Staff.list_stakeholder_roles()
    render(
      conn,
      "new.html",
      changeset: changeset,
      stakeholders: stakeholders,
      stakeholder_roles: stakeholder_roles,
      project_id: project_id
    )
  end

  def create(conn, %{"project_to_stakeholder" => project_to_stakeholder_params}) do
    case Research.create_project_to_stakeholder(project_to_stakeholder_params) do
      {:ok, project_to_stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder successfully added to project.")
        |> redirect(to: Routes.project_path(conn, :edit, project_to_stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        stakeholders = Staff.list_stakeholders()
        stakeholder_roles = Staff.list_stakeholder_roles()
        render(
          conn,
          "new.html",
          changeset: changeset,
          stakeholders: stakeholders,
          stakeholder_roles: stakeholder_roles,
          project_id: project_to_stakeholder_params["project_id"]
        )
    end
  end

  def edit(conn, %{"id" => id}) do
    project_to_stakeholder = Research.get_project_to_stakeholder!(id)
    changeset = Research.change_project_to_stakeholder(project_to_stakeholder)
    stakeholders = Staff.list_stakeholders()
    stakeholder_roles = Staff.list_stakeholder_roles()
    render(
      conn,
      "edit.html",
      project_to_stakeholder: project_to_stakeholder,
      changeset: changeset,
      stakeholders: stakeholders,
      stakeholder_roles: stakeholder_roles,
      project_id: project_to_stakeholder.project_id
    )
  end

  def update(conn, %{"id" => id, "project_to_stakeholder" => project_to_stakeholder_params}) do
    project_to_stakeholder = Research.get_project_to_stakeholder!(id)

    case Research.update_project_to_stakeholder(project_to_stakeholder, project_to_stakeholder_params) do
      {:ok, project_to_stakeholder} ->
        conn
        |> put_flash(:info, "Project's stakeholder updated successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, project_to_stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        stakeholders = Staff.list_stakeholders()
        stakeholder_roles = Staff.list_stakeholder_roles()
        render(
          conn,
          "edit.html",
          project_to_stakeholder: project_to_stakeholder,
          changeset: changeset,
          stakeholders: stakeholders,
          stakeholder_roles: stakeholder_roles,
          project_id: project_to_stakeholder.project_id
        )
    end
  end

  def delete(conn, %{"id" => id}) do
    project_to_stakeholder = Research.get_project_to_stakeholder!(id)
    {:ok, _} = Research.delete_project_to_stakeholder(project_to_stakeholder)

    conn
    |> put_flash(:info, "Project's association with stakeholder deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, project_to_stakeholder.project_id))
  end
end
