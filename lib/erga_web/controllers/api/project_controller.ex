defmodule ErgaWeb.Api.ProjectController do
  use ErgaWeb, :controller

  alias Erga.Research

  def index(conn, _params) do
    projects = Research.list_projects()
    render(conn, "list.json", projects: projects)
  end

  def show(conn, %{"id" => id}) do
    project = Research.get_project!(id)
    render(conn, "show.json", project: project)
  end
end
