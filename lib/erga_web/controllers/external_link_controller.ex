defmodule ErgaWeb.ExternalLinkController do
  use ErgaWeb, :controller

  alias Erga.Research
  alias Erga.Research.ExternalLink

  def new(conn, %{"project_id" => project_id}) do
    changeset =
      Research.change_external_link(%ExternalLink{})
      |> Ecto.Changeset.put_change(:project_id, project_id)

    render(conn, "new.html", changeset: changeset, project_id: project_id)
  end

  def create(conn, %{"external_link" => external_link_params}) do
    case Research.create_external_link(external_link_params) do
      {:ok, external_link} ->
        conn
        |> put_flash(:info, "External link created successfully, you may add some labels.")
        |> redirect(to: Routes.external_link_path(conn, :edit, external_link.id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    external_link = Research.get_external_link!(id)
    changeset = Research.change_external_link(external_link)
    render(conn, "edit.html", external_link: external_link, changeset: changeset)
  end

  def update(conn, %{"id" => id, "external_link" => external_link_params}) do
    external_link = Research.get_external_link!(id)

    case Research.update_external_link(external_link, external_link_params) do
      {:ok, external_link} ->
        conn
        |> put_flash(:info, "External link updated successfully.")
        |> redirect(to: Routes.project_path(conn, :edit, external_link.project_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", external_link: external_link, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    external_link = Research.get_external_link!(id)
    {:ok, _external_link} = Research.delete_external_link(external_link)

    conn
    |> put_flash(:info, "External link deleted successfully.")
    |> redirect(to: Routes.project_path(conn, :edit, external_link.project_id))
  end
end
