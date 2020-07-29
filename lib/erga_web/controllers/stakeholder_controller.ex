defmodule ErgaWeb.StakeholderController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.Stakeholder

  def index(conn, _params) do
    stakeholders = Research.list_stakeholders()
    render(conn, "index.html", stakeholders: stakeholders)
  end

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_stakeholder(%Stakeholder{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stakeholder" => stakeholder_params}) do
    case Research.create_stakeholder(stakeholder_params) do
      {:ok, stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder created successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stakeholder = Research.get_stakeholder!(id)
    render(conn, "show.html", stakeholder: stakeholder)
  end

  def edit(conn, %{"id" => id}) do
    stakeholder = Research.get_stakeholder!(id)
    changeset = Research.change_stakeholder(stakeholder)
    render(conn, "edit.html", stakeholder: stakeholder, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stakeholder" => stakeholder_params}) do
    stakeholder = Research.get_stakeholder!(id)

    case Research.update_stakeholder(stakeholder, stakeholder_params) do
      {:ok, stakeholder} ->
        conn
        |> put_flash(:info, "Stakeholder updated successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, stakeholder.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stakeholder: stakeholder, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "project_id" => project_id}) do
    stakeholder = Research.get_stakeholder!(id)
    {:ok, _stakeholder} = Research.delete_stakeholder(stakeholder)

    conn
    |> put_flash(:info, "Stakeholder deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, project_id))
  end

  def delete(conn, %{"id" => id}) do
    stakeholder = Research.get_stakeholder!(id)
    {:ok, _stakeholder} = Research.delete_stakeholder(stakeholder)

    conn
    |> put_flash(:info, "Stakeholder deleted successfully.")
    |> redirect(to: Routes.stakeholder_path(conn, :index))
  end
end
