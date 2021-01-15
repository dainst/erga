defmodule ErgaWeb.Api.ImageView do
  use ErgaWeb, :view

  @media_path Application.get_env(:erga, :media_path)

  def render("image.json", %{image: image}) do
    %{
      labels: render_many(image.labels, ErgaWeb.Api.TranslatedContentView, "translated_content.json"),
      primary: image.primary,
      path: "#{ErgaWeb.Endpoint.url()}#{@media_path}/#{image.path}"
    }
  end
end
