defmodule ErgaWeb.ProjectToStakeholderView do
  use ErgaWeb, :view

  def get_stakeholder_to_project_redirect("/projects_to_stakeholders/new", project_id) do
    "/projects_to_stakeholders/new?project_id=#{project_id}"
  end

  def get_stakeholder_to_project_redirect(request_path, _project_id) do
    request_path
  end
end
