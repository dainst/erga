defmodule ErgaWeb.Api.ExternalLinkView do
  use ErgaWeb, :view

  def render("external_link.json", %{external_link: external_link}) do
    %{
      labels: render_many(external_link.labels, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      url: external_link.url,
    }
  end
end
