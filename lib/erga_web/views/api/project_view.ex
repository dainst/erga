defmodule ErgaWeb.Api.ProjectView do
  use ErgaWeb, :view

  def render("list.json", %{projects: projects}) do
    %{data: render_many(projects, ErgaWeb.Api.ProjectView, "project_short.json")}
  end

  def render("show.json", %{project: project}) do
    %{data: render_one(project, ErgaWeb.Api.ProjectView, "project.json")}
  end

  def render("project.json", %{project: project}) do
    IO.inspect(project)
    %{
      id: project.id,
      project_key: project.project_code,
      title: render_many(project.title, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      description: render_many(project.description, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      stakeholders: render_many(project.stakeholders, ErgaWeb.Api.StakeholderView, "stakeholder.json"),
      linked_ressources: render_many(project.linked_resources, ErgaWeb.Api.LinkedResourceView, "linked_resource.json"),
      images: render_many(project.images, ErgaWeb.Api.ImageView, "image.json")
    }
  end

  def render("project_short.json", %{project: project}) do
    %{
      id: project.id,
      project_key: project.project_code,
      title: render_many(project.title, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      stakeholder_count: Enum.count(project.stakeholders),
      image_count: Enum.count(project.images)
    }
  end
end
