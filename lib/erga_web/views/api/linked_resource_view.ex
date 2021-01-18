defmodule ErgaWeb.Api.LinkedResourceView do
  use ErgaWeb, :view

  def render("linked_resource.json", %{linked_resource: lr}) do
    %{
      linked_system: lr.linked_system,
      uri: lr.uri,
      labels: render_many(lr.labels, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      descriptions: render_many(lr.descriptions, ErgaWeb.Api.TranslatedContentView, "translated_content.json")
    }
  end
end
