defmodule ErgaWeb.StakeholderController do
  use ErgaWeb, :controller
  alias ErgaWeb.ErrorHelpers
  alias Erga.Staff
  alias Erga.Staff.Stakeholder

  def index(conn,  %{"redirect" => redirect}) do
    stakeholders = Staff.list_stakeholders()
    render(conn, "index.html", stakeholders: stakeholders, redirect: redirect)
  end

  def new(conn, %{"redirect" => redirect}) do
    changeset = Staff.change_stakeholder(%Stakeholder{})
    render(conn, "new.html", changeset: changeset, redirect: redirect)
  end

  def create(conn, %{"stakeholder" => %{"redirect" => redirect} = stakeholder_params}) do
    case Staff.create_stakeholder(stakeholder_params) do
      {:ok, _stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder created successfully.")
        |> redirect(to: Routes.stakeholder_path(conn, :index, redirect: redirect))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, redirect: redirect)
    end
  end

  def edit(conn, %{"id" => id, "redirect" => redirect}) do
    stakeholder = Staff.get_stakeholder!(id)
    changeset = Staff.change_stakeholder(stakeholder)
    render(conn, "edit.html", stakeholder: stakeholder, redirect: redirect, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stakeholder" => %{"redirect" => redirect} = stakeholder_params}) do
    stakeholder = Staff.get_stakeholder!(id)

    case Staff.update_stakeholder(stakeholder, stakeholder_params) do
      {:ok, _stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder updated successfully.")
        |> redirect(to: Routes.stakeholder_path(conn, :index, redirect: redirect))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stakeholder: stakeholder, changeset: changeset, redirect: redirect)
    end
  end

  def delete(conn, %{"id" => id, "redirect" => redirect}) do
    stakeholder = Staff.get_stakeholder!(id)
    case Staff.delete_stakeholder(stakeholder) do
      {:ok, _changeset} ->
        conn
        |> put_flash(:info, "Stakeholder deleted successfully.")
        |> redirect(to: redirect)
      {:error, changeset} ->
        conn
        |> put_flash(:error, ErrorHelpers.changeset_error_to_string(changeset))
        |> redirect(to: redirect)
    end
  end

end
