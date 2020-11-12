defmodule ErgaWeb.LocaleController do
  use ErgaWeb, :controller

  def set(conn, %{"locale" => locale, "redirect" => redirect}) do
    Gettext.put_locale(locale)
    conn
    |> put_session(:locale, locale)
    |> put_flash(:info, "Locale changed to #{locale}.")
    |> redirect(to: redirect)
  end
end
