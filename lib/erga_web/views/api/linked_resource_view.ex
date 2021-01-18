defmodule ErgaWeb.Api.LinkedResourceView do
  use ErgaWeb, :view

  def render("linked_resource.json", %{linked_resource: lr}) do
    %{
      linked_system: lr.linked_system,
      uri: lr.uri,
      res_id: read_id_from_uri(lr.uri ),
      labels: render_many(lr.labels, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      descriptions: render_many(lr.descriptions, ErgaWeb.Api.TranslatedContentView, "translated_content.json")
    }
  end

  def read_id_from_uri( uri ) do
    parser = fn
        "https://gazetteer.dainst.org/place/" <> id  -> id
        "https://chronontology.dainst.org/period/" <> id -> id
        _ -> raise "No match for given uri please add pattern to function"
    end
    parser.(uri)
  end
end
