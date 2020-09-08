defmodule ErgaWeb.Api.ImageView do
  use ErgaWeb, :view

  def render("image.json", %{image: image}) do
    %{
      label: image.label,
      primary: image.primary,
      path: image.path
    }
  end
end
