defmodule ErgaWeb.Api.ProjectView do
  use ErgaWeb, :view

  def render("list.json", %{projects: projects}) do
    %{data: render_many(projects, ErgaWeb.Api.ProjectView, "project.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ErgaWeb.Api.ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    %{
      id: project.id,
      project_key: project.project_code,
      title: project.title,
      description: project.description,
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      stakeholders: render_many(project.stakeholders, ErgaWeb.Api.StakeholderView, "stakeholder.json")
    }
  end
end
