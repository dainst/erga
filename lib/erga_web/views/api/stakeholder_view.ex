defmodule ErgaWeb.Api.StakeholderView do
  use ErgaWeb, :view

  def render("stakeholder.json", %{stakeholder: stakeholder}) do
    %{
      title: stakeholder.role,
      person: render_one(stakeholder.person, ErgaWeb.Api.PersonView, "person.json")
    }
  end
end
