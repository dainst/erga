defmodule ErgaWeb.ProjectView do
  use ErgaWeb, :view
  def primary_images(images) do
    Enum.filter(images, fn image -> image.primary end)
  end

  def other_images(images) do
    Enum.filter(images, fn image -> !image.primary end)
  end
end
