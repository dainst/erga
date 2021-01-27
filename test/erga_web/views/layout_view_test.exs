defmodule ErgaWeb.LayoutViewTest do
  use ErgaWeb.ConnCase, async: true

  alias ErgaWeb.LayoutView


  # When testing helpers, you may want to import Phoenix.HTML and
  # use functions such as safe_to_string() to convert the helper
  # result into an HTML string.
  # import Phoenix.HTML

  def serve_translations(_) do
    %{trans: [
      %Erga.Research.TranslatedContent{
        id: 3,
        inserted_at: ~N[2020-11-24 09:46:14],
        language_code: "de",
        target_id: 1,
        text: "Großartiges Ausgrabungsprojekt",
        updated_at: ~N[2020-11-24 09:46:14]
      },
      %Erga.Research.TranslatedContent{
        id: 4,
        inserted_at: ~N[2020-11-24 09:46:14],
        language_code: "en",
        target_id: 1,
        text: "Great digging project",
        updated_at: ~N[2020-11-24 09:46:14]
      }
    ]}
  end

  describe "translations" do
    setup [:serve_translations]

    test "no translations no text" do
      assert LayoutView.get_translated_content([]) == ""
    end

    test "get the default translation", %{trans: trans} do
      # make sure the default local set in the configs is what we expect
      assert Gettext.get_locale() == "de"
      assert LayoutView.get_translated_content(trans) == "Großartiges Ausgrabungsprojekt"
    end

    test "get the english translation", %{trans: trans} do
      Gettext.put_locale("en")
      assert LayoutView.get_translated_content(trans) == "Great digging project"
    end

    test "get the default if locale not in translation", %{ trans: trans} do
      Gettext.put_locale("la")
      assert LayoutView.get_translated_content(trans) == "Großartiges Ausgrabungsprojekt"
    end

  end
end
