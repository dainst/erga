defmodule ErgaWeb.Api.ProjectToStakeholderView do
  use ErgaWeb, :view

  def render("project_to_stakeholder.json", %{project_to_stakeholder: project_to_stakeholder}) do
    %{
      role: project_to_stakeholder.stakeholder_role.tag,
      person: render_one(project_to_stakeholder.stakeholder, ErgaWeb.Api.StakeholderView, "stakeholder.json")
    }
  end
end
