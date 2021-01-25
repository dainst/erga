defmodule ErgaWeb.Api.StakeholderView do
  use ErgaWeb, :view

  def render("stakeholder.json", %{stakeholder: stakeholder}) do
    %{
      role: stakeholder.role,
      person: render_one(stakeholder.person, ErgaWeb.Api.PersonView, "person.json")
    }
  end
end
