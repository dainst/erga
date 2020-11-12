defmodule ErgaWeb.ProjectView do
  use ErgaWeb, :view

  defp get_translated_content([]) do
    ""
  end

  defp get_translated_content(translations) do

    translation =
      translations
      |> Enum.filter(fn t -> t.translated_content.language_code == Gettext.get_locale end)

    case translation do
      [] ->
        List.first(translations).translated_content.text
      [val] ->
        val.translated_content.text
      end
  end

  def primary_images(images) do
    Enum.filter(images, fn image -> image.primary end)
  end

  def other_images(images) do
    Enum.filter(images, fn image -> !image.primary end)
  end
end
