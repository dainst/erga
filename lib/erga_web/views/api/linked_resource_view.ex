defmodule ErgaWeb.Api.LinkedResourceView do
  use ErgaWeb, :view

  def render("linked_resource.json", %{linked_resource: lr}) do
    %{
      linked_system: lr.linked_system,
      uri: lr.uri,
      label: lr.label,
      description: lr.description
    }
  end
end
