defmodule ErgaWeb.Api.LinkedResourceView do
  use ErgaWeb, :view

  require Logger

  def render("linked_resource.json", %{linked_resource: lr}) do
    %{
      linked_system: lr.linked_system,
      uri: lr.uri,
      res_id: get_id(lr),
      labels: render_many(lr.labels, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      descriptions: render_many(lr.descriptions, ErgaWeb.Api.TranslatedContentView, "translated_content.json")
    }
  end

  def get_id( %Erga.Research.LinkedResource{} = linked_resource ) do
    service = ErgaWeb.Services.get_system_service(linked_resource.linked_system)

    case service.get_resource_id_from_uri(linked_resource.uri) do
      :error ->
        Logger.error("Unable to extract resource ID from URI #{linked_resource.uri}, system: #{linked_resource.linked_system}.")
        ""
      id ->
        id
    end
  end
end
