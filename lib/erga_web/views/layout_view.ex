defmodule ErgaWeb.LayoutView do
  use ErgaWeb, :view

  import Plug.Conn

  def get_locale_select_values() do
    Application.get_env(:gettext, :locales)
    |> Enum.map(fn locale -> {locale, locale} end)
  end

  def get_locale_selected(conn) do
    get_session(conn, :locale)
  end

  def get_translated_content([]) do
    ""
  end

  def get_translated_content(translations) do
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
end
