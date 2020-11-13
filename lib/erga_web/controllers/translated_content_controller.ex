defmodule ErgaWeb.TranslatedContentController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.TranslatedContent

  @lang_codes Application.get_env(:gettext, :locales)

  def new(conn, params) do
    changeset = Research.change_translated_content(%TranslatedContent{})
    render(conn, "new.html", changeset: changeset, lang_codes: @lang_codes, params: params)
  end

  def create(conn, %{"translated_content" => translated_content_params}) do
    case Research.create_translated_content(translated_content_params) do
      {:ok, _translated_content} ->
        # assoc =
        #   translated_content_params
        #   |> Map.put("translated_content_id", translated_content.id)
        #   |> Research.assoc_translated_content

        conn
        |> put_flash(:info, "Translated content created successfully.")
        |> redirect(to: translated_content_params["redirect"])

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, lang_codes: @lang_codes, params: translated_content_params)
    end
  end

  def edit(conn, %{ "id" => id } = params) do
    translated_content = Research.get_translated_content!(id)
    changeset = Research.change_translated_content(translated_content)
    render(
      conn,
      "edit.html",
      translated_content: translated_content,
      changeset: changeset,
      lang_codes: @lang_codes,
      params: Map.merge(%{"target_id" => translated_content.target_id}, params)
    )
  end

  def update(conn, %{"id" => id, "translated_content" => translated_content_params}) do
    translated_content = Research.get_translated_content!(id)

    case Research.update_translated_content(translated_content, translated_content_params) do
      {:ok, _translated_content} ->
        conn
        |> put_flash(:info, "Translated content updated successfully.")
        |> redirect(to: translated_content_params["redirect"])

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", translated_content: translated_content, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "redirect" => redirect}) do
    translated_content = Research.get_translated_content!(id)
    {:ok, _translated_content} = Research.delete_translated_content(translated_content)

    conn
    |> put_flash(:info, "Translated content deleted successfully.")
    |> redirect(to: redirect)
  end
end
