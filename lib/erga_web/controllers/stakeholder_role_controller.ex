defmodule ErgaWeb.StakeholderRoleController do
  use ErgaWeb, :controller

  alias Erga.Staff
  alias Erga.Staff.StakeholderRole

  def index(conn,  %{"redirect" => redirect}) do
    stakeholder_roles = Staff.list_stakeholder_roles()
    render(conn, "index.html", stakeholder_roles: stakeholder_roles, redirect: redirect)
  end

  def new(conn, %{"redirect" => redirect}) do
    changeset = Staff.change_stakeholder_role(%StakeholderRole{})
    render(conn, "new.html", changeset: changeset, redirect: redirect)
  end

  def create(conn, %{"stakeholder_role" => %{"redirect" => redirect} = stakeholder_role_params}) do
    case Staff.create_stakeholder_role(stakeholder_role_params) do
      {:ok, _stakeholder_role} ->
        conn
        |> put_flash(:info, "Stakeholder role created successfully.")
        |> redirect(to: Routes.stakeholder_role_path(conn, :index, redirect: redirect))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, redirect: redirect)
    end
  end

  def edit(conn, %{"id" => id, "redirect" => redirect}) do
    stakeholder_role = Staff.get_stakeholder_role!(id)
    changeset = Staff.change_stakeholder_role(stakeholder_role)
    render(conn, "edit.html", stakeholder_role: stakeholder_role, redirect: redirect, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stakeholder_role" => %{"redirect" => redirect} = stakeholder_role_params}) do
    stakeholder_role = Staff.get_stakeholder_role!(id)

    case Staff.update_stakeholder_role(stakeholder_role, stakeholder_role_params) do
      {:ok, _stakeholder_role} ->
        conn
        |> put_flash(:info, "Stakeholder role updated successfully.")
        |> redirect(to: Routes.stakeholder_role_path(conn, :index, redirect: redirect))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stakeholder_role: stakeholder_role, changeset: changeset, redirect: redirect)
    end
  end

  def delete(conn, %{"id" => id}) do
    stakeholder_role = Staff.get_stakeholder_role!(id)
    {:ok, _stakeholder_role} = Staff.delete_stakeholder_role(stakeholder_role)

    conn
    |> put_flash(:info, "Stakeholder role deleted successfully.")
    |> redirect(to: Routes.stakeholder_role_path(conn, :index))
  end
end
