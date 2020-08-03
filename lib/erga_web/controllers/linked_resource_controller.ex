defmodule ErgaWeb.LinkedResourceController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.LinkedResource

  def index(conn, _params) do
    linked_resources = Research.list_linked_resources()
    render(conn, "index.html", linked_resources: linked_resources)
  end

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_linked_resource(%LinkedResource{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"linked_resource" => linked_resource_params}) do
    case Research.create_linked_resource(linked_resource_params) do
      {:ok, linked_resource} ->
        conn
        |> put_flash(:info, "Linked resource created successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, linked_resource.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    linked_resource = Research.get_linked_resource!(id)
    render(conn, "show.html", linked_resource: linked_resource)
  end

  def edit(conn, %{"id" => id}) do
    linked_resource = Research.get_linked_resource!(id)
    changeset = Research.change_linked_resource(linked_resource)
    render(conn, "edit.html", linked_resource: linked_resource, changeset: changeset)
  end

  def update(conn, %{"id" => id, "linked_resource" => linked_resource_params}) do
    linked_resource = Research.get_linked_resource!(id)

    case Research.update_linked_resource(linked_resource, linked_resource_params) do
      {:ok, linked_resource} ->
        conn
        |> put_flash(:info, "Linked resource updated successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, linked_resource.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", linked_resource: linked_resource, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "project_id" => project_id}) do
    stakeholder = Research.get_linked_resource!(id)
    {:ok, _stakeholder} = Research.delete_linked_resource(stakeholder)

    conn
    |> put_flash(:info, "Linked resource deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, project_id))
  end

  def delete(conn, %{"id" => id}) do
    linked_resource = Research.get_linked_resource!(id)
    {:ok, _linked_resource} = Research.delete_linked_resource(linked_resource)

    conn
    |> put_flash(:info, "Linked resource deleted successfully.")
    |> redirect(to: Routes.linked_resource_path(conn, :index))
  end
end
