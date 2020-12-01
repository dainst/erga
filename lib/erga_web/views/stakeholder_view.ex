defmodule ErgaWeb.StakeholderView do
  use ErgaWeb, :view

  def get_person_redirect("/stakeholders/new", project_id) do
    "/stakeholders/new?project_id=#{project_id}"
  end

  def get_person_redirect(request_path, _project_id) do
    request_path
  end
end
