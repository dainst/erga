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
end
