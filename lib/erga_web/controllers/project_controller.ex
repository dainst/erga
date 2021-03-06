defmodule ErgaWeb.ProjectController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.Project

  def index(conn, _params) do
    projects = Research.list_projects()
    render(conn, "index.html", projects: projects)
  end

  def new(conn, _params) do
    changeset = Research.change_project(%Project{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"project" => project_params}) do
    case Research.create_project(project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project created successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
      try do
        project = Research.get_project!(id)
        render(conn, "show.html", project: project)
      rescue
        _e in Ecto.NoResultsError ->
          conn
          |> put_flash(:error, "Project ID not found.")
          |> redirect(to: Routes.project_path(conn, :index))
      end
  end

  def edit(conn, %{"id" => id}) do
    project = Research.get_project!(id)
    changeset = Research.change_project(project)
    render(conn, "edit.html", project: project, changeset: changeset)
  end

  def update(conn, %{"id" => id, "project" => project_params}) do
    project = Research.get_project!(id)

    case Research.update_project(project, project_params) do
      {:ok, project} ->
        conn
        |> put_flash(:info, "Project updated successfully.")
        |> redirect(to: Routes.project_path(conn, :show, project))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", project: project, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    project = Research.get_project!(id)
    {:ok, project} = Research.toggle_inactive(project)

    message =
      if project.inactive do
        "Project deleted successfully."
      else
        "Project restored successfully."
      end

    conn
    |> put_flash(:info, message)
    |> redirect(to: Routes.project_path(conn, :index))
  end
end
