defmodule ErgaWeb.Gettext do
  @moduledoc """
  A module providing Internationalization with a gettext-based API.

  By using [Gettext](https://hexdocs.pm/gettext),
  your module gains a set of macros for translations, for example:

      import ErgaWeb.Gettext

      # Simple translation
      gettext("Here is the string to translate")

      # Plural translation
      ngettext("Here is the string to translate",
               "Here are the strings to translate",
               3)

      # Domain-based translation
      dgettext("errors", "Here is the error message to translate")

  See the [Gettext Docs](https://hexdocs.pm/gettext) for detailed usage.
  """
  use Gettext, otp_app: :erga

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
