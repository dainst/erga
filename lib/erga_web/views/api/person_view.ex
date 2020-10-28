defmodule ErgaWeb.Api.PersonView do
  use ErgaWeb, :view

  def render("person.json", %{person: person}) do
    %{
      #id: stakeholder.id,
      firstname: person.firstname,
      lastname: person.lastname,
      title: person.title
    }
  end
end
