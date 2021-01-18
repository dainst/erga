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
      starts_at: project.starts_at,
      ends_at: project.ends_at,
      titles: render_many(project.titles, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      descriptions: render_many(project.descriptions, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      stakeholders: render_many(project.stakeholders, ErgaWeb.Api.StakeholderView, "stakeholder.json"),
      linked_resources: render_many(project.linked_resources, ErgaWeb.Api.LinkedResourceView, "linked_resource.json"),
      external_links: render_many(project.external_links, ErgaWeb.Api.ExternalLinkView, "external_link.json"),
      images: render_many(project.images, ErgaWeb.Api.ImageView, "image.json")
    }
  end

  def render("project_short.json", %{project: project}) do
    %{
      id: project.id,
      project_key: project.project_code,
      starts_at: project.starts_at,
      ends_at: project.ends_at,
      titles: render_many(project.titles, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      inserted_at: project.inserted_at,
      updated_at: project.updated_at,
      stakeholder_count: Enum.count(project.stakeholders),
      linked_resources: render_many(project.linked_resources, ErgaWeb.Api.LinkedResourceView, "linked_resource.json"),
      image_count: Enum.count(project.images)
    }
  end

  def render("error.json", err) do
    %{
      error: err.name,
      msg: err.msg,
      code: err.code
     }
  end

end
