defmodule ErgaWeb.ProjectToStakeholderView do
  use ErgaWeb, :view

  def get_stakeholder_to_project_redirect("/project_to_stakeholder/new", project_id) do
    "/project_to_stakeholder/new?project_id=#{project_id}"
  end

  def get_stakeholder_to_project_redirect(request_path, _project_id) do
    request_path
  end
end
