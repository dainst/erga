defmodule ErgaWeb.Api.ProjectView do
  use ErgaWeb, :view

  def render("list.json", %{projects: projects}) do
    %{data: render_many(projects, ErgaWeb.Api.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ErgaWeb.Api.ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{project_id: project.project_id,
        title: project.title,
        description: project.description,
      }
  end

end
