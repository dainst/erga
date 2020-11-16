defmodule ErgaWeb.ProjectView do
  use ErgaWeb, :view

  defp get_translated_content([]) do
    ""
  end

  defp get_translated_content(translations) do

    translation =
      translations
      |> Enum.filter(fn t -> t.language_code == Gettext.get_locale end)

    case translation do
      [] ->
        List.first(translations).text
      [val] ->
        val.text
      end
  end

  def primary_images(images) do
    Enum.filter(images, fn image -> image.primary end)
  end

  def other_images(images) do
    Enum.filter(images, fn image -> !image.primary end)
  end
end
