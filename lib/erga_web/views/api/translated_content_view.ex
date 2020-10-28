defmodule ErgaWeb.Api.TranslatedContentView do
  use ErgaWeb, :view

  def render("translated_content.json", %{translated_content: tc}) do
    %{
      language_code: tc.language_code,
      content: tc.content
    }
  end
end
