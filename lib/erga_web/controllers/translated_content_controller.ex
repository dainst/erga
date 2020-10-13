defmodule ErgaWeb.TranslatedContentController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.TranslatedContent

  def index(conn, _params) do
    translated_contents = Research.list_translated_contents()
    render(conn, "index.html", translated_contents: translated_contents)
  end

  def new(conn, _params) do
    changeset = Research.change_translated_content(%TranslatedContent{})
    render(conn, "new.html", changeset: changeset, lang_codes: [de: "DE", en: "EN"])
  end

  def create(conn, %{"translated_content" => translated_content_params}) do
    case Research.create_translated_content(translated_content_params) do
      {:ok, translated_content} ->
        conn
        |> put_flash(:info, "Translated content created successfully.")
        |> redirect(to: Routes.translated_content_path(conn, :show, translated_content))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    translated_content = Research.get_translated_content!(id)
    render(conn, "show.html", translated_content: translated_content)
  end

  def edit(conn, %{"id" => id}) do
    translated_content = Research.get_translated_content!(id)
    changeset = Research.change_translated_content(translated_content)
    render(conn, "edit.html", translated_content: translated_content, changeset: changeset)
  end

  def update(conn, %{"id" => id, "translated_content" => translated_content_params}) do
    translated_content = Research.get_translated_content!(id)

    case Research.update_translated_content(translated_content, translated_content_params) do
      {:ok, translated_content} ->
        conn
        |> put_flash(:info, "Translated content updated successfully.")
        |> redirect(to: Routes.translated_content_path(conn, :show, translated_content))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", translated_content: translated_content, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    translated_content = Research.get_translated_content!(id)
    {:ok, _translated_content} = Research.delete_translated_content(translated_content)

    conn
    |> put_flash(:info, "Translated content deleted successfully.")
    |> redirect(to: Routes.translated_content_path(conn, :index))
  end
end
