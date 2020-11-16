
  defmodule ErgaWeb.Gettext.Plug do

  import Plug.Conn

  def init(_opts), do: nil

  def call(conn, _opts) do
    locale =
    case get_session(conn, :locale) do
      nil ->
        Application.get_env(:gettext, :default_locale)
      locale ->
        locale
    end

    Gettext.put_locale(locale)
    conn
    |> put_session(:locale, locale)
  end
end
