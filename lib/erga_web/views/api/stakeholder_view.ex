defmodule ErgaWeb.Api.StakeholderView do
  use ErgaWeb, :view

  def render("stakeholder.json", %{stakeholder: stakeholder}) do
    %{
      #id: stakeholder.id,
      type: stakeholder.type,
      title: stakeholder.role,
      label: stakeholder.person_id
    }
  end
end
