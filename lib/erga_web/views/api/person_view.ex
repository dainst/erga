defmodule ErgaWeb.Api.PersonView do
  use ErgaWeb, :view

  def render("person.json", %{person: person}) do
    %{
      firstname: person.firstname,
      lastname: person.lastname,
      title: person.title,
      external_id: person.external_id
    }
  end
end
