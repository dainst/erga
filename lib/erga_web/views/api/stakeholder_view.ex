defmodule ErgaWeb.Api.StakeholderView do
  use ErgaWeb, :view

  def render("stakeholder.json", %{stakeholder: stakeholder}) do
    %{
      first_name: stakeholder.first_name,
      last_name: stakeholder.last_name,
      title: stakeholder.title,
      orc_id: stakeholder.orc_id,
      organization_name: stakeholder.organization_name,
      ror_id: stakeholder.ror_id
    }
  end
end
